Public Class CRM_OrganizationUnit
    Inherits WebPages.Template.WhizTemplate
    Private WithEvents m_objOUGrid As New WebPages.Template.GenericGrid
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
        ' Author                :	Dipali V
        ' Created               :	10th Jan 2018
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

    End Sub
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
        ' Author                :Dipali Vekhande
        ' Created               :10 jan 2018
        ' Revisions             : None
        '=====================================================================
        '/*Changed By Yasmin on 25th july 2018*/

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar' id='CustomerFilter'>")

        strHTML.Append("<ul class='left'>")
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
            strHTML.Append("<button type='button' class='btn btn-default' title='Add Organization Unit' onclick='AddOU()'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If
        'If m_objAccess.Delete = True Then
        '    strHTML.Append("<li class='clearall'>")
        '    strHTML.Append(" <button type='button' class='btn btn-default' title='Delete' onclick='DeleteOu()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
        '    strHTML.Append("</li>")
        'End If
        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        Return strHTML.ToString
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
        ' Author                :Dipali V
        ' Created Date           :10-Jan-2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_OrganizationUnit As New CRM_OrganizationUnit()
            strGridHTML.Append(objCRM_OrganizationUnit.WritePage("1"))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    Protected Function DrawGrid() As String
        '=====================================================================
        ' Procedure Name        :DrawGrid()
        ' Purpose               : To Plot OU grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali Vekhande
        ' Created               : 10-Jan-2018
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
        strDivID = "divOU"
        strSQLQuery = "usp_NG2_Sel_tbl_PM_Location "

        arrstrActualList = {"Location", "LocationCode", "Active", "Edit", ""}
        arrstrUserFriendlyList = {"Organization Unit", "Organization Unit Code", "Active", "Edit", "Delete"}
        arrstrLinkArray = {"", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=center", "align=center", "align=center"}
        objGrid = m_objOUGrid
        If Flag = 0 Then
            With objGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList

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
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With



            objGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function

    Private Sub m_objOUGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objOUGrid.ColumnHeaderTD_BeforePrint

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteSelect_OU()' type=checkbox id=chkAllOU name=chkAllOU title='Select All'/></th>"
        End If


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
        ' Author                : Dipali Vekhande
        ' Created               :10-Jan-2018
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
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'>Add New Organization Unit </span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' id='Addaccordion' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class=''><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        strHTML.Append("<div class='panel-body'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> Organization Unit* </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("OrganizationUnit", "OrganizationUnit", "form-control", 219, 50, , , , , , , , " class='form-control'  placeholder='Enter Organization Unit' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))

        strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Active </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(" <input type='checkbox' style='width:12px;' id='CheckActive'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> Organization Unit Server Name </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("OrganizationUnitServer", "OrganizationUnitServer", "form-control", 219, 100, , , , , , , , " class='form-control'  placeholder='Enter OU Server Name' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> Organization Unit Code *</label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("OrganizationUnitCode", "OrganizationUnitCode", "form-control", 219, 10, , , , , , , , " class='form-control'  placeholder='Enter Organization Unit  Code' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Short Code </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ShortCode", "ShortCode", "form-control", 219, 4, , , , , , , , " class='form-control'  placeholder='Enter ShortCode  Code' onkeypress='validateLength()' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> Address 1 </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Address1", "Address1", "form-control", 219, 40, , , , , , , , " class='form-control'  placeholder='Enter Address1' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Address 2 </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Address2", "Address2", "form-control", 219, 40, , , , , , , , " class='form-control'  placeholder='Enter Address 2' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> City </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("City", "City", "form-control", 219, 30, , , , , , , , " class='form-control'  placeholder='Enter City' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Zip</label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Zip", "Zip", "form-control", 219, 10, , , , , , , , " class='form-control'  placeholder='Enter Zip' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> State </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("State", "State", "form-control", 219, 20, , , , , , , , " class='form-control'  placeholder='Enter State' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Country</label>")
        strHTML.Append("<div class='col-sm-3'>")
        Dim sql As String = "usp_Sel_tbl_PM_CountryMaster 1"
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboCountry", sql, 199, , " class='form-control clscombo' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> Phone Number 1 </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Ph1", "Ph1", "form-control", 219, 50, , , , , , , , " class='form-control'  placeholder='Enter Phone Number 1' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Phone Number 2</label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Ph2", "Ph2", "form-control", 219, 50, , , , , , , , " class='form-control'  placeholder='Enter Phone Number 2' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> Fax </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Fax", "Fax", "form-control", 219, 50, , , , , , , , " class='form-control'  placeholder='Enter Fax' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Email</label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Email", "Email", "form-control", 219, 50, , , , , , , , " class='form-control'  placeholder='Enter Email' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3' for='Employee Type' style='text-align: right;'> Working Hours* </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("WorkingH", "WorkingH", "form-control", 219, 20, , , , , , , , " class='form-control'  placeholder='Enter Working Hours' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Working Days*</label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("WorkingD", "WorkingD", "form-control", 219, 20, , , , , , , , " class='form-control'  placeholder='Enter Working Days' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


       

        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right'>")
        If m_objAccess.Add = True Or m_objAccess.Edit = True Then
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save'  onclick='SaveOU()' style='background-color: #343660; color: #ffffff'>Save</button>")
            strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks'  onclick='SaveAndAddOU()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        strHTML.Append("<button type='button' id='History' class='btn btn-default save clsbuttonLinks'  onclick='ShowHistory_OnClick()' style=' display:none; margin-left: 5px; background-color: #343660; color: #ffffff'>Show History</button>")
        strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks'  onclick='CancelOU()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff'>Cancel</button>")
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


    Private Sub m_objOUGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objOUGrid.DataRowTD_BeforePrint
        Dim CheckEnable As String

        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'  title='Edit Organization Unit'><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""EditOU_OnClick(" & Args.DataReader("LocationID") & ")""   id='Editdata_" & Args.DataReader("LocationID") & "'></i></td>"
            Args.StringToBeInserted += "<input type='hidden' id='txthdnOU_" & Args.DataReader("LocationID") & "' value='" & Args.DataReader("LocationID") & "'>"

        End If

        If Args.ColumnName.ToUpper = "ACTIVE" Then
            Cancel = True

            If Args.DataReader("Active") = True Then
                Args.StringToBeInserted = "<td>Yes</td>"
            Else
                Args.StringToBeInserted = "<td>No</td>"
            End If
        End If

        ' End If
        'If Args.ColumnName.ToUpper = "ACTIVE" Then
        '    Cancel = True
        '    Dim M_Active As Boolean = False
        '    If M_Active = Args.DataReader("Active") Then
        '        If M_Active = True Then
        '            Args.StringToBeInserted = "Yes"
        '        Else
        '            Args.StringToBeInserted = "No"
        '        End If

        '    End If

        'End If

        'Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteOU()' type=checkbox id=chkAllOU1 name=chkAllOU1 title='Select All'/></th>"
        Dim m_strCanOUDelete As String = ""
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanOUDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Del_d_tbl_CNF_OUMappedRequestBG " & Args.DataReader("LocationID"), True), "0")

            If m_strCanOUDelete = "0" Then
                Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Delete Organization Unit'><input type=checkbox id=chkAllOU name=chkAllOU  onclick='select_checkbox(this)' value=" & Args.DataReader("LocationID") & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td style='text-align:center;'' Title='You do not have access to delete that record'><input type=checkbox id=chkAllOU name=chkAllOU disabled value=" & Args.DataReader("LocationID") & " onclick='select_checkbox(this)'>" + "</TD>"
            End If
        End If

    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function GetOUDetails(ByVal OUID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetOUDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get OU Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	dipali Vekhande
        ' Created				: 10th Jan 2018
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim Location As String = ""
            Dim LocationCode As String = ""
            Dim BusinessGroupCode As String = ""
            Dim OUPoolID As String = ""
            Dim NoOfResources As String = ""
            Dim Active As String = ""
            Dim OrgnztionServername As String = ""
            Dim ShrtCode As String = ""
            Dim Address1 As String = ""
            Dim Address As String = ""
            Dim City As String = ""
            Dim Zip As String = ""
            Dim State As String = ""
            Dim Country As String = ""
            Dim Ph1 As String = ""
            Dim Ph2 As String = ""
            Dim Email As String = ""
            Dim Fax As String = ""
            Dim WorkHrs As String = ""
            Dim WorkDays As String = ""
            Dim strSQL As String = ""
            Dim BusinessID As String = ""
            strSQL = "usp_NG2_Sel_tbl_PM_LocationEdit  " & OUID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                Location = CommonFunctions.Data.CheckIsDBNull(drTabData("Location"), "")
                Active = CommonFunctions.Data.CheckIsDBNull(drTabData("Active"), "")
                OrgnztionServername = CommonFunctions.Data.CheckIsDBNull(drTabData("LocationServerName"), "")
                ShrtCode = CommonFunctions.Data.CheckIsDBNull(drTabData("ShortCode"), "")
                Address = CommonFunctions.Data.CheckIsDBNull(drTabData("Address"), "")
                Address1 = CommonFunctions.Data.CheckIsDBNull(drTabData("Address1"), "")
                City = CommonFunctions.Data.CheckIsDBNull(drTabData("City"), "")
                Zip = CommonFunctions.Data.CheckIsDBNull(drTabData("Zip"), "")
                State = CommonFunctions.Data.CheckIsDBNull(drTabData("State"), "")
                Country = CommonFunctions.Data.CheckIsDBNull(drTabData("CountryID"), "")
                Ph1 = CommonFunctions.Data.CheckIsDBNull(drTabData("Phone1"), "")

                Ph2 = CommonFunctions.Data.CheckIsDBNull(drTabData("Phone2"), "")
                Fax = CommonFunctions.Data.CheckIsDBNull(drTabData("Fax"), "")
                Email = CommonFunctions.Data.CheckIsDBNull(drTabData("Email"), "")

                WorkHrs = CommonFunctions.Data.CheckIsDBNull(drTabData("WorkingHours"), "")

                WorkDays = CommonFunctions.Data.CheckIsDBNull(drTabData("WorkingDays"), "")
                BusinessID = CommonFunctions.Data.CheckIsDBNull(drTabData("BusinessID"), "")
                LocationCode = CommonFunctions.Data.CheckIsDBNull(drTabData("LocationCode"), "")
            End If
            strResult = Location & "##" & Active & "##" & OrgnztionServername & "##" & ShrtCode & "##" & Address & "##" & Address1 & "##" & City & "##" & Zip & "##" & State & "##" & Country & "##" & Ph1 & "##" & Ph2 & "##" & Fax & "##" & Email & "##" & WorkHrs & "##" & WorkDays & "##" & LocationCode


            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SaveOUDetails(ByVal OrganizationUnit As String, ByVal CheckActive As String, ByVal OrganizationUnitServer As String, ByVal OrganizationUnitCode As String, ByVal ShortCode As String, ByVal Address1 As String, ByVal Address2 As String, ByVal City As String, ByVal Zip As String, ByVal State As String, ByVal Country As String, ByVal Ph1 As String, ByVal Ph2 As String, ByVal Email As String, ByVal Fax As String, ByVal WorkingD As String, ByVal WorkingH As String, ByVal OUID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveOUDetails
        ' Description           : To  Save OU Details
        ' Created Date           : 10th Jan 2018
        '=====================================================================
        Try

            Dim m_intUniqueID As Integer = 0
            Dim strSQL As String
            Dim m_BGId As String

            If OrganizationUnit = "" Then
                OrganizationUnit = "Null"
            End If

            If OrganizationUnitServer = "" Then
                OrganizationUnitServer = "Null"
            End If

            If OrganizationUnitCode = "" Then
                OrganizationUnitCode = "Null"
            End If

            If ShortCode = "" Then
                ShortCode = "Null"
            End If

            If City = "" Then
                City = "Null"
            End If

            If zip = "" Then
                zip = "Null"
            End If

            If Email = "" Then
                Email = "Null"
            End If

            If Ph1 = "" Then
                Ph1 = "Null"
            End If

            If Ph2 = "" Then
                Ph2 = "Null"
            End If

            If Country = "" Then
                Country = "Null"
            End If

            If State = "" Then
                State = "Null"
            End If

            If WorkingD = "" Then
                WorkingD = "Null"
            End If

            If Ph2 = "" Then
                Ph2 = "Null"
            End If

            If WorkingH = "" Then
                WorkingH = "Null"
            End If


            strSQL = "exec usp_NG2_Ins_upd_tbl_PM_Location  '" & OrganizationUnit & "'," & CheckActive & ",'" & OrganizationUnitServer & "','" & OrganizationUnitCode & "','" & ShortCode & "','" & Address1 & "','" & Address2 & "','" & City & "','" & Zip & "','" & State & "'," & Country & ",'" & Ph1 & "','" & Ph2 & "','" & Fax & "','" & Email & "'," & WorkingH & "," & WorkingD & ",'" & HttpContext.Current.Session("strUserName") & "'," & OUID & ""
            m_BGId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))


            Return m_BGId
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckOUName(ByVal Flag As String, ByVal OUName As String, ByVal OUID As String)
        '==================================================================================
        ' Procedure Name	:	CheckBGName
        ' Purpose			:	To check is duplicate OUName Name 
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Dipali V
        ' Created			:	10-jan-2018
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
        'If Flag = "BG" Then
        '    strSQL = "usp_NG2_Sel_All_BGExistOrNot '" & OUName & "'," & OUID & ""
        'Else

        strSQL = "usp_NG2_Sel_All_OUExistOrNot '" & OUName & "'," & OUID & ",'" & Flag & "'"
        'End If
        strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

        Return strResult
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function ShowMailHistoryDetails(ByVal UniqueID As Integer)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryDetails                              '
        ' Purpose				:   Call ShowMailHistoryGrid function                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :  Dipali V                                   '
        '*******************************************************************************'
        Try
            Dim CRM_OrganizationUnit As New CRM_OrganizationUnit
            StrEditUniqueID = UniqueID
            Dim strHTML As New StringBuilder("")
            Dim str As String = CRM_OrganizationUnit.ShowMailHistoryGrid(UniqueID, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    Public Function ShowMailHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryGrid                                 '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   UniqueID                                            '
        ' Returns               :   grid                                                '
        ' Author                :   Dipali v                                  '
        '*******************************************************************************'
        '/*Changed By Yasmin on 25th july 2018*/
        Try
            Dim strHTML As New StringBuilder("")

            If (storedprocedure = Nothing) Then
                txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 395 & "','" & UniqueID & "'")
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
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
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
        ' Author                : Dipali V
        ' Created               : 10-Jan-2018
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            Dim CRM_OrganizationUnit As New CRM_OrganizationUnit
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 395, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"

            Dim str As String = CRM_OrganizationUnit.ShowMailHistoryGrid(MessageID, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request Found"
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
        ' Author                : Dipali V
        ' Created               : 
        ' Revisions             :
        '===============================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
End Class