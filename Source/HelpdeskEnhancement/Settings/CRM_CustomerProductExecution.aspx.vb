Public Class CRM_CustomerProductExecution
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objProductGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected WithEvents objComponentGrid As WebPages.Template.GenericGrid
    Protected WithEvents objProductComponentGrid As WebPages.Template.GenericGrid
    Protected WithEvents objAMCGrid As WebPages.Template.GenericGrid
    Protected WithEvents objLicenseGrid As WebPages.Template.GenericGrid
    Protected WithEvents objReleaseGrid As WebPages.Template.GenericGrid
    Protected WithEvents objSelectProductGrid As WebPages.Template.GenericGrid
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected TagID As String = "3698"
    Protected m_intRoleID As Integer = 0
    Protected strLoginType = ""
    Protected Shared m_objCurrentTagAccess As WebPage.Templates.AccessRights
    Protected Shared m_objSubTabAccess As WebPage.Templates.AccessRights
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        GetAccessRights()
    End Sub
    Protected Sub GetAccessRights()
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
        ' Created               :	05-jaN
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(HttpContext.Current.Session("strUserName").ToString, TagID, m_intRoleID, CType(HttpContext.Current.Session("intUserID"), Integer), strLoginType)
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
        ' Created               :05-JAN-2017
        ' Revisions             : None
        '=====================================================================

        Dim strHTML As New StringBuilder("")
        strHTML.Append(DrawFilter(strflag))
        strHTML.Append("<div class='table-responsive' id='divCustomerProduct'>")
        strHTML.Append(DrawGrid())
        strHTML.Append("</div>")

        ''Grid Plotting End
        ''Collapse Button Start
        strHTML.Append("<div class='bottom-bar' id='divSubTypeBottom'>")
      
        strHTML.Append("</div>")

        ''Collapse Button End      
        'If strflag = "1" Then
        '    Return strHTML.ToString()
        'Else
        CommonFunction.General.WriteHTML(strHTML.ToString)
        'End If
    End Function
    Protected Function SubTagSection(Optional ByVal CustomerProductId As String = "") As String
        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'> Product Version </span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class='' id='Addaccordion'><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        strHTML.Append(CustomerProductDetails(CustomerProductId))
        strHTML.Append("</div>")
        strHTML.Append(GetTabs(CustomerProductId))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString()
    End Function
    Protected Function CustomerProductDetails(Optional ByVal CustomerProductId As String = "")
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = "usp_NG2_Tbl_PRD_Customer_ProductVersion " & CustomerProductId
        Dim strCustomer As String = ""
        Dim strProductLine As String = ""
        Dim strProduct As String = ""
        Dim strProductVersion As String = ""
        Dim strDescrition As String = ""
        Dim strInstallationDate As String = ""
        Dim drProduct As IDataReader
        Dim IsCurrentVersion As Boolean
        drProduct = CommonFunction.Data.GetDataReader(strSQL, True)
        If drProduct.Read Then

            If CustomerProductId <> "" Then
                strProductLine = CommonFunction.Data.CheckIsDBNull(drProduct("ProductLine"), "")
                strCustomer = CommonFunction.Data.CheckIsDBNull(drProduct("CustomerName"), "")
                strProduct = CommonFunction.Data.CheckIsDBNull(drProduct("Product"), "")
                strProductVersion = CommonFunction.Data.CheckIsDBNull(drProduct("ProductVersion"), "")
                strInstallationDate = CommonFunction.Data.CheckIsDBNull(drProduct("InstalledOn"), "")
                IsCurrentVersion = CType(CommonFunction.Data.CheckIsDBNull(drProduct("IsCurrentVersion"), "0"), Boolean)
            End If
        End If
        '/*Changed By Yasmin on 27th july 2018*/
        strHTML.Append("<div class='panel-body' style='nav nav-tabs tablinks1'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2 clsBold' for='Employee Type' style='text-align: right;'> Customer </label>")
        strHTML.Append("<div class='col-sm-8'>")
        strHTML.Append("<label class='control-label col-sm-8' for='Employee Type' style='text-align: left;'>  " & strCustomer & "  </label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2 clsBold'  style='text-align: right;font-size: 11px'> Product Line </label>")
        strHTML.Append("<div class='col-sm-8'>")
        strHTML.Append("<label class='control-label col-sm-8' for='Employee Type' style='text-align: left;'> " & strProductLine & " </label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")

        strHTML.Append("<label class='control-label col-sm-2 clsBold'  style='text-align: right;font-size: 11px'> Product Version </label>")
        strHTML.Append("<div class='col-sm-8'>")
        strHTML.Append("<label class='control-label col-sm-8' for='Employee Type' style='text-align: left;'> " & strProductVersion & " </label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' >")
        strHTML.Append("<label class='control-label col-sm-2 clsBold' style='text-align: right; font-size: 12px;'>Installation Date*</label>")
        strHTML.Append("<div class='col-sm-8' style='display:inline-flex' >")
        strHTML.Append("<div>")
        strHTML.Append("<input type='text' value='" & strInstallationDate & "'  class='form-control' id='dtInstallOn' placeholder=''>")

        strHTML.Append("</div>")
        strHTML.Append("<div>")
        strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtInstallOn').datepicker({orientation: 'right top'});$('#dtInstallOn').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2 clsBold'  style='text-align: right;font-size: 11px'> Is Current Version </label>")
        strHTML.Append("<div class='col-sm-8' style='padding-top:7px'>")
        If IsCurrentVersion = "1" Then
            strHTML.Append("<input  type=checkbox id=chkIsCurrentVersion checked name=chkIsCurrentVersion />")
        Else
            strHTML.Append("<input  type=checkbox id=chkIsCurrentVersion  name=chkIsCurrentVersion />")
        End If


        strHTML.Append(" [Note: Only current version of a product will be available for adding new help-desk request]")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right'>")

        If m_objAccess.Add = True Or m_objAccess.Edit = True Then
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveCustomerProduct(" & CustomerProductId & ")' style='background-color: #343660; color: #ffffff'>Save</button>")
        End If



        strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Product()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff'>Cancel</button>")
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
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar' id='ProductFilter'>")

        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'>")
        strHTML.Append("<label class='control-label ' style='text-align: right; font-size: 12px;'>Customer</label>")
        strHTML.Append("<div class='' style='display:inline-flex;margin-left:5px' >")
        strHTML.Append("<div>")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboCustomer", "usp_sel_tbl_PM_Customer ", 300, , "onChange='CustomerOnChange(this)'", True, True, "form-control"))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")

        strHTML.Append("<ul class='right'>")
        strHTML.Append("<li class='clearall'>")
        strHTML.Append("<button type='button' class='btn btn-default' onclick='SelectProduct()' title='Select Product'>Select Product<i class='fa fa-plus' aria-hidden='true' ></i></button>")
        strHTML.Append("</li>")

        If m_objAccess.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append(" <button type='button' class='btn btn-default' title='Delete Product' onclick='DeleteProduct()' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If

        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function DrawGrid(Optional ByVal CustomerID As String = "") As String
        '=====================================================================
        ' Procedure Name        : DrawGrid()
        ' Purpose               : To Plot Customer  product  grid
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


        intNoOfDataColumn = 6
        strDivID = "divCustomerProductGrid"
        strSQLQuery = "usp_NG2_Tbl_PRD_Customer_ProductVersion NULL,"
        If (CustomerID = "") Then
            strSQLQuery += "NULL"
        Else
            strSQLQuery += CustomerID
        End If

        arrstrActualList = {"CustomerName", "ProductLine", "Product", "ProductVersion", "InstalledOn", "IsCurrentVersion", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Customer", "Product Line", "Product", "Product Version", "Installation Date", "Is Current Version", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center", "align=left", "align=center", "align=center"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objGrid = m_objProductGrid
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
                '.GroupOnColumn = arrstrGroupOnColumn
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
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'   title='Edit Product Details' ><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""ProductVersion_OnClick(" & Args.DataReader("CustomerProductVersionID") & ")""  id='Editdata_" & Args.DataReader("CustomerProductVersionID") & "'></i></td>"



        End If

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Product'><input type=checkbox id=chkProductDelete name=chkProductDelete  value=" & Args.DataReader("CustomerProductVersionID") & " >" + "</TD>"

        End If


    End Sub
    Private Sub objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteMultiple_Product()' type=checkbox id=chkAllProduct name=chkAllProduct title='Select All'/></th>"
        End If


    End Sub
    Public Function GetTabs(Optional ByVal CustomerProductId As String = "")
        Dim strGridHTML As New StringBuilder()
        Dim strTabHTML As New StringBuilder()
        strGridHTML.Append("<div class='col-sm-9' id='divTabs'>")
        strGridHTML.Append("<ul class='nav nav-tabs tablinks1' style='margin: 35px 0 22px 0;'>")




        GetSubTabAccessRights(3202, TagID)
        If m_objSubTabAccess.View = True Then
            strGridHTML.Append("<li class='active'><a data-toggle='tab' href='#ComponentDetails'>Module/Components Details</a></li>")
            strTabHTML.Append("<div id='ComponentDetails' class='tab-pane fade in active bottom-bar'>")
            strTabHTML.Append("<div class='type-top-bar top-bar'>")

            If m_objSubTabAccess.Add = True Then
                strTabHTML.Append("<ul class='right'>")
                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button'  title='Select Module/Components'  onclick='SelectModuleComponent_Onclick(" & CustomerProductId & ")' class='btn btn-default' style='color:black!important;background-color:white!important'>Select Module/Components<i class='fa fa-plus' aria-hidden='true'style='display:inline-block'></i></button></li>")
                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' class='btn btn-default' title='Delete Module/Component' onclick='DeleteModuleComponent_Onclick(" & CustomerProductId & ")' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                strTabHTML.Append("</li>")
                strTabHTML.Append("</ul>")
            End If
            strTabHTML.Append("</div>")
            strTabHTML.Append(ComponentDetails(CustomerProductId))
            ''''''''''''''
            strTabHTML.Append(" <div class='pannel-section'>")
            strTabHTML.Append("<div class='col-md-12 col-sm-12'>")

            strTabHTML.Append("<div class='panel-group wrap' id='accordion33' role='tablist' aria-multiselectable='true'>")
            strTabHTML.Append("<div class='panel'>")
            strTabHTML.Append("<div class='panel-heading' role='tab' id='panelComponentAdd' style='display:none'>")
            strTabHTML.Append("<h3 style='font-size: 13px;'><span>Module/Components Details</span></h3>")
            strTabHTML.Append("<h4 class='panel-title'>")
            strTabHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne33' aria-expanded='true' aria-controls='collapseOne'>")
            strTabHTML.Append("<i class='fa fa-plus' title='Expand' style = 'line-height: 0px;'></i>")
            strTabHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
            strTabHTML.Append("</a>")
            strTabHTML.Append("</h4>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("<div id='collapseOne33' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
            strTabHTML.Append("<div class='panel-body' id='panelModuleComponent'>")








            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            '''''''''''''''''''''
            strTabHTML.Append("</div>")
        End If

        GetSubTabAccessRights(3203, TagID)
        If m_objSubTabAccess.View = True Then

            strGridHTML.Append("<li class=''><a data-toggle='tab' href='#AMCDetails'>Add AMC Details</a></li>")
            strTabHTML.Append("<div id='AMCDetails' class='tab-pane fade in  bottom-bar'>")
            strTabHTML.Append("<div class='type-top-bar top-bar'>")
            strTabHTML.Append("<ul class='right'>")
            If m_objSubTabAccess.Add = True Then

                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' title='Add AMC Detail'  onclick=AMCEdit_OnClick(''," & CustomerProductId & ") class='btn btn-default' style='color:black!important;background-color:white!important'>Add<i class='fa fa-plus' aria-hidden='true'style='display:inline-block'></i></button></li>")
            End If
            If m_objSubTabAccess.Delete = True Then
                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' class='btn btn-default' title='Delete AMC Detail' onclick='DeleteAMC_Onclick(" & CustomerProductId & ")' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                strTabHTML.Append("</li>")
            End If


            strTabHTML.Append("</ul>")
            strTabHTML.Append("</div>")
            strTabHTML.Append(AMCDetails(CustomerProductId))

            strTabHTML.Append(" <div class='pannel-section'>")
            strTabHTML.Append("<div class='col-md-12 col-sm-12'>")

            strTabHTML.Append("<div class='panel-group wrap' id='accordion34' role='tablist' aria-multiselectable='true'>")
            strTabHTML.Append("<div class='panel'>")
            strTabHTML.Append("<div class='panel-heading' role='tab' id='panelAMCAdd' style='display:none'>")
            strTabHTML.Append("<h3 style='font-size: 13px;'><span>AMC Details</span></h3>")
            strTabHTML.Append("<h4 class='panel-title'>")
            strTabHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne34' aria-expanded='true' aria-controls='collapseOne'>")
            strTabHTML.Append("<i class='fa fa-plus' title='Expand' style = 'line-height: 0px;'></i>")
            strTabHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
            strTabHTML.Append("</a>")
            strTabHTML.Append("</h4>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("<div id='collapseOne34' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
            strTabHTML.Append("<div class='panel-body' id='panelAMC'>")








            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
        End If
        GetSubTabAccessRights(3205, TagID)
        If m_objSubTabAccess.View = True Then

            strGridHTML.Append("<li class=''><a data-toggle='tab' href='#LicensesDetails'>Licenses</a></li>")
            strTabHTML.Append("<div id='LicensesDetails' class='tab-pane fade in  bottom-bar'>")
            strTabHTML.Append("<div class='type-top-bar top-bar'>")
            strTabHTML.Append("<ul class='right'>")
            If m_objSubTabAccess.Add = True Then

                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' title='Add License'  onclick=LicenseEdit_OnClick(''," & CustomerProductId & ") class='btn btn-default' style='color:black!important;background-color:white!important'>Add<i class='fa fa-plus' aria-hidden='true'style='display:inline-block'></i></button></li>")
            End If
            If m_objSubTabAccess.Delete = True Then
                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' class='btn btn-default' title='Delete License' onclick='DeleteLicense_Onclick(" & CustomerProductId & ")' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                strTabHTML.Append("</li>")
            End If


            strTabHTML.Append("</ul>")
            strTabHTML.Append("</div>")
            strTabHTML.Append(LicensesDetails(CustomerProductId))

            strTabHTML.Append(" <div class='pannel-section'>")
            strTabHTML.Append("<div class='col-md-12 col-sm-12'>")

            strTabHTML.Append("<div class='panel-group wrap' id='accordion35' role='tablist' aria-multiselectable='true'>")
            strTabHTML.Append("<div class='panel'>")
            strTabHTML.Append("<div class='panel-heading' role='tab' id='panellicenseAdd' style='display:none'>")
            strTabHTML.Append("<h3 style='font-size: 13px;'><span>Licenses</span></h3>")
            strTabHTML.Append("<h4 class='panel-title'>")
            strTabHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne35' aria-expanded='true' aria-controls='collapseOne'>")
            strTabHTML.Append("<i class='fa fa-plus' title='Expand' style = 'line-height: 0px;'></i>")
            strTabHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
            strTabHTML.Append("</a>")
            strTabHTML.Append("</h4>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("<div id='collapseOne35' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
            strTabHTML.Append("<div class='panel-body' id='panelLicense'>")








            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")

        End If

        GetSubTabAccessRights(3209, TagID)
        If m_objSubTabAccess.View = True Then
            strGridHTML.Append("<li class=''><a data-toggle='tab' href='#ReleasesDetails'>Releases</a></li>")


            strTabHTML.Append("<div id='ReleasesDetails' class='tab-pane fade in  bottom-bar'>")
            strTabHTML.Append("<div class='type-top-bar top-bar'>")
            strTabHTML.Append("<ul class='right'>")
            If m_objSubTabAccess.Add = True Then

                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' title='Add New Release' onclick=ReleaseEdit_OnClick(''," & CustomerProductId & ") class='btn btn-default' style='color:black!important;background-color:white!important'>New Release<i class='fa fa-plus' aria-hidden='true'style='display:inline-block'></i></button></li>")
            End If
            If m_objSubTabAccess.Delete = True Then
                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' class='btn btn-default' title='Delete Release' onclick='DeleteRelease_Onclick(" & CustomerProductId & ")' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                strTabHTML.Append("</li>")
            End If


            strTabHTML.Append("</ul>")
            strTabHTML.Append("</div>")
            strTabHTML.Append(ReleasesDetails(CustomerProductId))

            strTabHTML.Append(" <div class='pannel-section'>")
            strTabHTML.Append("<div class='col-md-12 col-sm-12'>")

            strTabHTML.Append("<div class='panel-group wrap' id='accordion36' role='tablist' aria-multiselectable='true'>")
            strTabHTML.Append("<div class='panel'>")
            strTabHTML.Append("<div class='panel-heading' role='tab' id='panelReleaseAdd' style='display:none'>")
            strTabHTML.Append("<h3 style='font-size: 13px;'><span>Releases</span></h3>")
            strTabHTML.Append("<h4 class='panel-title'>")
            strTabHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne36' aria-expanded='true' aria-controls='collapseOne'>")
            strTabHTML.Append("<i class='fa fa-plus' title='Expand' style = 'line-height: 0px;'></i>")
            strTabHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
            strTabHTML.Append("</a>")
            strTabHTML.Append("</h4>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("<div id='collapseOne36' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
            strTabHTML.Append("<div class='panel-body' id='panelRelease'>")








            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
        End If
        strGridHTML.Append("</ul>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='tab-content'>")


        strGridHTML.Append(strTabHTML.ToString)



        strGridHTML.Append("</div>")
        Return strGridHTML.ToString()
    End Function
    Protected Function ComponentDetails(ByVal CustomerProductId As String) As String
        '=====================================================================
        ' Procedure Name        : ComponentDetails()
        ' Purpose               : To Plot component  details  grid
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
        '/*Changed By Yasmin on 25th july 2018*/
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




        intNoOfDataColumn = 3
        strDivID = "divComponentGrid"
        strSQLQuery = "usp_NG2_Sel_Tbl_PRD_Customer_ProductVersionComponents " & CustomerProductId


        arrstrActualList = {"ComponentType", "ComponentCode", "Component", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Module/Component Type", "Module/Component Code", "Module/Component", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objComponentGrid = m_objProductGrid
        If Flag = 0 Then
            With objComponentGrid
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

                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objComponentGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function
    Private Sub objComponentGrid_ColumnHeaderTH_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objComponentGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='SelectAll_Module(this)' type=checkbox id=chkAllSelectModule name=chkAllSelectModule title='Select All'/></th>"
        End If


    End Sub
    Private Sub objComponentGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objComponentGrid.DataRowTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Module/Component'><input type=checkbox id=chkComponentDelete name=chkComponentDelete   value=" & Args.DataReader("uniqueID") & " >" + "</TD>"

        End If
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'   title='Edit Module/Component Detail' ><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""ProductComponent_OnClick(" & Args.DataReader("uniqueID") & ")""   id='EditComponetdata_" & Args.DataReader("uniqueID") & "'></i></td>"



        End If

    End Sub

    Protected Function AMCDetails(ByVal CustomerProductId As String) As String
        '=====================================================================
        ' Procedure Name        : AMCDetails()
        ' Purpose               : To Plot AMC  details  grid
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
        '/*Changed By Yasmin on 25th july 2018*/
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




        intNoOfDataColumn = 8
        strDivID = "divAMCGrid"
        strSQLQuery = "usp_NG2_Sel_Tbl_PRD_Customer_ProductVersion_AMC " & CustomerProductId


        arrstrActualList = {"AMCFrom", "AMCTo", "AMCDueDate", "ProductValidity", "CurrencyName", "AMCAmount", "AMCCollected", "EmployeeName", "Edit", "Delete"}
        arrstrUserFriendlyList = {"AMC From", "AMC To", "AMC Due Date", " Product Validity", "  Currency", "AMC Amount", "Collected AMC", "Responsible Person", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", "", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center", "align=left", "align=center", "align=center", "align=left", "align=center"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objAMCGrid = m_objProductGrid
        If Flag = 0 Then
            With objAMCGrid
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

                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objAMCGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function
    Private Sub objAMCGrid_ColumnHeaderTH_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objAMCGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='SelectAll_AMC(this)' type=checkbox id=chkAllSelectAMC name=chkAllSelectAMC title='Select All'/></th>"
        End If


    End Sub
    Private Sub objAMCGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objAMCGrid.DataRowTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete AMC Detail'><input type=checkbox id=chkAMCDelete name=chkAMCDelete   value=" & Args.DataReader("ID") & " >" + "</TD>"

        End If
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'   title='Edit AMC Detail'><i class='fa fa-pencil-square-o' data-placement='bottom' style='font-size:16px!important;cursor:pointer;' onclick=""AMCEdit_OnClick(" & Args.DataReader("ID") & "," & Args.DataReader("CustomerProductVersionID") & ")""  id='EditComponetdata_" & Args.DataReader("ID") & "'></i></td>"

        End If

    End Sub

    Protected Function LicensesDetails(ByVal CustomerProductId As String) As String
        '=====================================================================
        '/*Changed By Yasmin on 25th july 2018*/
        ' Procedure Name        : LicensesDetails()
        ' Purpose               : To Plot  Licenses  details  grid
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




        intNoOfDataColumn = 8
        strDivID = "divLicenseGrid"
        strSQLQuery = "usp_NG2_Tbl_PRD_Customer_ProductVersion_License " & CustomerProductId


        arrstrActualList = {"RefernceDate", "Description", "Quantity", "PriceUnit", "PricePerUnit", "DiscountPercent", "Amount", "DiscountedAmount", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Reference Date", "Description", "Quantity", "Price Unit", "Price Per Unit", "Discount %", "Amount", "Total Price	", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", "", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center", "align=left", "align=center", "align=center", "align=left", "align=center"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objLicenseGrid = m_objProductGrid
        If Flag = 0 Then
            With objLicenseGrid
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

                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objLicenseGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function
    Private Sub objLicenseGrid_ColumnHeaderTH_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objLicenseGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='SelectAll_License(this)' type=checkbox id=chkAllSelectLicense name=chkAllSelectLicense title='Select All'/></th>"
        End If


    End Sub
    Private Sub objLicenseGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objLicenseGrid.DataRowTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete License'><input type=checkbox id=chkLicenseDelete name=chkLicenseDelete   value=" & Args.DataReader("CustomerProductLicenseID") & " >" + "</TD>"

        End If
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'   title='Edit License Detail' ><i class='fa fa-pencil-square-o' data-placement='bottom' style='font-size:16px!important;cursor:pointer;' onclick=""LicenseEdit_OnClick(" & Args.DataReader("CustomerProductLicenseID") & "," & Args.DataReader("CustomerProductVersionID") & ")""  id='EditLicenseData_" & Args.DataReader("CustomerProductLicenseID") & "'></i></td>"

        End If

    End Sub
    Protected Function ReleasesDetails(ByVal CustomerProductId As String) As String
        '=====================================================================
        ' Procedure Name        : ReleasesDetails()
        ' Purpose               : To Plot  Licenses  details  grid
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
        '/*Changed By Yasmin on 25th july 2018*/
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




        intNoOfDataColumn = 2
        strDivID = "divReleaseGrid"
        strSQLQuery = "usp_NG2_SEL_tbl_PRD_Release " & CustomerProductId


        arrstrActualList = {"Subject", "ReleaseDate", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Subject", "Release Date", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objReleaseGrid = m_objProductGrid
        If Flag = 0 Then
            With objReleaseGrid
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

                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objReleaseGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function
    Private Sub objReleaseGrid_ColumnHeaderTH_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objReleaseGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='SelectAll_Release(this)' type=checkbox id=chkAllRelease name=chkAllRelease title='Select All'/></th>"
        End If


    End Sub
    Private Sub objReleaseGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objReleaseGrid.DataRowTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Release'><input type=checkbox id=chkReleaseDelete name=chkReleaseDelete   value=" & Args.DataReader("ReleaseID") & " >" + "</TD>"

        End If
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'   title='Edit Release'><i class='fa fa-pencil-square-o'  style='font-size:16px!important;cursor:pointer;' onclick=""ReleaseEdit_OnClick(" & Args.DataReader("ReleaseID") & "," & Args.DataReader("CustomerProductVersionID") & ")""   id='EditReleaseData_" & Args.DataReader("ReleaseID") & "'></i></td>"

        End If

    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function FilterData(ByVal CustomerID As String)
        '=====================================================================
        ' Procedure  Name		:	FilterData
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim objCustomerProduct As New CRM_CustomerProductExecution()
            strHTML.Append(objCustomerProduct.DrawGrid(CustomerID))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function PlotCustomerProduct(ByVal CustomerProductVersionID As String)
        '=====================================================================
        ' Procedure  Name		:	PlotCustomerProduct
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Plot Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim objCustomerProduct As New CRM_CustomerProductExecution()
            Dim strHTML As New StringBuilder("")
            objCustomerProduct.TagID = "3698"
            objCustomerProduct.m_intRoleID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0), Integer)
            objCustomerProduct.strLoginType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), 0)
            objCustomerProduct.GetAccessRights()

            strHTML.Append(objCustomerProduct.SubTagSection(CustomerProductVersionID))

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    Public Function GetCurrentTagAccessRights(ByVal CurrentTagID As String)
        '=====================================================================
        ' Procedure Name        :	GetCurrentTagAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Yogesh Jalamkar
        ' Created               :	08-JAN-2017
        ' Revisions             :
        '=====================================================================

        m_objCurrentTagAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(HttpContext.Current.Session("strUserName"), CurrentTagID, m_intRoleID, CType(HttpContext.Current.Session("intUserID"), Integer), strLoginType)
        m_objCurrentTagAccess.GetAccess(objGlobal)

    End Function

    Public Function GetSubTabAccessRights(ByVal SubtagID As Integer, ByVal TagID As String)
        '=====================================================================
        ' Procedure Name        :	GetSubTabAccessRights
        ' Purpose               :	Get the Access Details for the Sub Tag 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Yogesh Jalamkar
        ' Created               :	08-JAN-2017
        ' Revisions             :
        '=====================================================================

        m_objSubTabAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(HttpContext.Current.Session("strUserName"), SubtagID, m_intRoleID, HttpContext.Current.Session("intUserID"), strLoginType, False, TagID)
        m_objSubTabAccess.GetAccess(objGlobal)

        'GetSubTabAccessRights(3365, RequestTypeTagID)

        'If m_objSubTabAccess.View Then
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateCustomerProduct(ByVal CustomerProductId As String, ByVal InstallationDate As String, ByVal IsCurrentVersion As String)
        '=====================================================================
        ' Procedure  Name		:	UpdateCustomerProduct
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Dim strSQL As String
        Dim strResult As String = "0"
        Try
            strSQL = "usp_NG2_Upd_Tbl_PRD_Customer_ProductVersion '" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'," & CustomerProductId & ",'" & InstallationDate & "'," & IsCurrentVersion
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SelectProduct(CustomerID)
        '=====================================================================
        ' Procedure  Name		:	SelectProductDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	select product details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder()
            Dim objCustomerProduct As New CRM_CustomerProductExecution()
            strHTML.Append(objCustomerProduct.SelectProductGrid(CustomerID))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    Protected Function SelectProductGrid(ByVal CustomerID As String) As String
        '=====================================================================
        '/*Changed By Yasmin on 25th july 2018*/
        ' Procedure Name        : SelectProductGrid()
        ' Purpose               : To Plot  select product grid
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




        intNoOfDataColumn = 3
        strDivID = "divSelectProductGrid"
        strSQLQuery = "usp_NG2_Sel_Tbl_PRD_Product " & CustomerID


        arrstrActualList = {"ProductLine", "Product", "ProductVersion", "Select"}
        arrstrUserFriendlyList = {"Product Line", "Product", "Product Version", "Select"}

        arrstrLinkArray = {"", "", "", ""}
        arrCheckBoxArray = {"", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objSelectProductGrid = m_objProductGrid
        If Flag = 0 Then
            With objSelectProductGrid
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
                .GroupOnColumn = arrstrGroupOnColumn
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objSelectProductGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function
    Private Sub objSelectProductGrid_ColumnHeaderTH_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objSelectProductGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='SelectAll_Product(this)' type=checkbox id=chkAllSelectProduct name=chkAllSelectProduct title='Select All'/></th>"
        End If


    End Sub
    Private Sub objSelectProductGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objSelectProductGrid.DataRowTD_BeforePrint



        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkProductDelete name=chkProductSelect onclick='selectProduct_checkbox(this)'  value=" & Args.DataReader("ProductVersionID") & " >" + "</TD>"

        End If


    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveProduct(CustomerID, selectProductIDs)
        '=====================================================================
        ' Procedure  Name		:	SaveProduct
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim strResult As String = "0"

        Dim strSQl As String = "Usp_INS_Tbl_PRD_Customer_ProductVersion " & CustomerID & ",'" & selectProductIDs & "'"
        Try
            CommonFunction.Data.InsertOrUpdateData(strSQl, True)
            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshGrid(Customer)
        '=====================================================================
        ' Procedure  Name		:	RefreshGrid
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Refresh grid 
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim objCustomerProduct As New CRM_CustomerProductExecution()
        Try
            strHTML.Append(objCustomerProduct.DrawGrid(Customer))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SelectProductComponent(ByVal CustomerProductVersionID As String)
        '=====================================================================
        ' Procedure  Name		:	SelectProductComponent
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	select product component 
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder()
            Dim objCustomerProduct As New CRM_CustomerProductExecution()
            strHTML.Append(objCustomerProduct.SelectProductComponentGrid(CustomerProductVersionID))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    Protected Function SelectProductComponentGrid(ByVal CustomerProductVersionID As String) As String
        '=====================================================================
        '/*Changed By Yasmin on 25th july 2018*/
        ' Procedure Name        : SelectProductComponentGrid()
        ' Purpose               : To Plot  select product component grid
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

        intNoOfDataColumn = 5
        strDivID = "divProductComponentGrid"
        strSQLQuery = "usp_NG2_Tbl_PRD_Customer_productVersionComponents_Selection " & CustomerProductVersionID


        arrstrActualList = {"ComponentType", "ComponentCode", "Component", "PricePerUnit", "DiscountPercentage", "Select"}
        arrstrUserFriendlyList = {"Module/Component Type", "Module/Component Code", "Module/Component", "List Price", "Discount Percentage", "Select"}

        arrstrLinkArray = {"", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center", "align=center"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objProductComponentGrid = m_objProductGrid
        If Flag = 0 Then
            With objProductComponentGrid
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

                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objProductComponentGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function
    Private Sub objProductComponentGridDataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objProductComponentGrid.DataRowTD_BeforePrint



        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            If (CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProductVersionID"), ""), String) <> "") Then

                Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkProductDelete name=chkProductComponentSelect onclick='selectProduct_checkbox(this)' checked  value=" & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ComponentID"), ""), String) & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkProductDelete name=chkProductComponentSelect onclick='selectProduct_checkbox(this)'   value=" & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ComponentID"), ""), String) & " >" + "</TD>"
            End If
        End If


    End Sub
    Private Sub objProductComponentGrid_ColumnHeaderTH_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objProductComponentGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='SelectAll_ProductComponent(this)' type=checkbox id=chkAllSelectProductComponent name=chkAllSelectProductComponent title='Select All'/></th>"
        End If


    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveProductComponents(ByVal CustomerProductVersionID As String, ByVal ProductComponentIDS As String)
        '=====================================================================
        ' Procedure  Name		:	SaveProductComponents
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save selected product components
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim strResult As String = "0"

        Dim strSQl As String = "Usp_INS_tbl_PRD_Customer_ProductVersionComponents " & CustomerProductVersionID & ",'" & ProductComponentIDS & "'"
        Try
            CommonFunction.Data.InsertOrUpdateData(strSQl, True)
            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"


        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetComponentDetails(ByVal UniqueID As String)
        '=====================================================================
        ' Procedure  Name		:	GetComponentDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:    To get component details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim strSQL As String = "usp_NG2_Sel_Tbl_PRD_Customer_ProductVersionComponents null," & UniqueID
            Dim strModuleComponentCode As String = ""
            Dim strModuleComponent As String = ""
            Dim strModuleComponentType As String = ""

            Dim strDescription As String = ""

            Dim drComponent As IDataReader

            drComponent = CommonFunction.Data.GetDataReader(strSQL, True)
            If drComponent.Read Then


                strModuleComponentCode = CommonFunction.Data.CheckIsDBNull(drComponent("ComponentCode"), "")
                strModuleComponent = CommonFunction.Data.CheckIsDBNull(drComponent("Component"), "")
                strModuleComponentType = CommonFunction.Data.CheckIsDBNull(drComponent("ComponentType"), "")

                strDescription = CommonFunction.Data.CheckIsDBNull(drComponent("Description"), "")
            End If
            strHTML.Append("<div class='panel-body' >")
            strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 clsBold' for='Employee Type' style='text-align: right;'> Module/Component Code </label>")
            strHTML.Append("<div class='col-sm-8'>")
            strHTML.Append("<label class='control-label col-sm-8' for='Employee Type' style='text-align: left;'>  " & strModuleComponentCode & "  </label>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")




            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 clsBold'  style='text-align: right;font-size: 11px'> Module/Component </label>")
            strHTML.Append("<div class='col-sm-8'>")
            strHTML.Append("<label class='control-label col-sm-8' for='Employee Type' style='text-align: left;'> " & strModuleComponent & " </label>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='form-group'>")

            strHTML.Append("<label class='control-label col-sm-2 clsBold'  style='text-align: right;font-size: 11px'> Module/Component Type  </label>")
            strHTML.Append("<div class='col-sm-8'>")
            strHTML.Append("<label class='control-label col-sm-8' for='Employee Type' style='text-align: left;'> " & strModuleComponentType & " </label>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='form-group'>")

            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Description </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComponentDescription", "txtComponentDescription", , "form-control", , , , , 208, 56, , strDescription, , "  class='form-control' placeholder='Enter Description' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
            strHTML.Append("<div class='right'>")
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='UpdateComponent(" & UniqueID & ")' style='background-color: #343660; color: #ffffff'>Save</button>")
            strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Module()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff' >Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateComponentDetails(ByVal UniqueID As String, ByVal Description As String)
        '=====================================================================
        ' Procedure  Name		:	UpdateComponentDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:    To update component details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Dim strSQL As String
        Dim strResult As String = ""
        strSQL = "usp_NG2_Upd_Tbl_PRD_Customer_ProductVersionComponents " & UniqueID & ",'" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName").ToString, "") & "','" & Description & "'"
        Try
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetAMCDetails(ByVal UniqueID As String, ByVal CustomerProductVersionID As String)
        '=====================================================================
        ' Procedure  Name		:	GetAMCDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:    To get AMC details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim strSQL As String = "usp_NG2_Sel_Tbl_PRD_Customer_ProductVersion_AMC " & CustomerProductVersionID & "," & UniqueID
            Dim strAMCFrom As String = ""
            Dim strAMCTo As String = ""
            Dim strAMCDueDate As String = ""
            Dim strCurrency As String = ""
            Dim strProductValidity As String = ""
            Dim strAMCAmount As String = ""
            Dim strResponsiblePerson As String = ""
            Dim strDescription As String = ""

            Dim drAMC As IDataReader

            If UniqueID <> "" Then
                drAMC = CommonFunction.Data.GetDataReader(strSQL, True)
                If drAMC.Read Then


                    strAMCFrom = CommonFunction.Data.CheckIsDBNull(drAMC("AMCFrom"), "")
                    strAMCTo = CommonFunction.Data.CheckIsDBNull(drAMC("AMCTo"), "")
                    strAMCDueDate = CommonFunction.Data.CheckIsDBNull(drAMC("AMCDueDate"), "")
                    strAMCAmount = CommonFunction.Data.CheckIsDBNull(drAMC("AMCAmount"), "")
                    strProductValidity = CommonFunction.Data.CheckIsDBNull(drAMC("ProductValidity"), "")
                    strCurrency = CommonFunction.Data.CheckIsDBNull(drAMC("CurrencyID"), "")
                    strResponsiblePerson = CommonFunction.Data.CheckIsDBNull(drAMC("ResponsiblePerson"), "")
                    strDescription = CommonFunction.Data.CheckIsDBNull(drAMC("Description"), "")



                End If
            End If
            strHTML.Append("<div class='form-group' >")
            strHTML.Append("<label class='control-label col-sm-2 ' style='text-align: right; font-size: 12px;'>AMC From*</label>")
            strHTML.Append("<div class='col-sm-8' style='display:inline-flex' >")
            strHTML.Append("<div>")
            strHTML.Append("<input type='text' value='" & strAMCFrom & "'  class='form-control' id='dtAMCFrom' placeholder=''>")

            strHTML.Append("</div>")
            strHTML.Append("<div>")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtAMCFrom').datepicker({orientation: 'right top'});$('#dtAMCFrom').datepicker('show');""></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='form-group' >")
            strHTML.Append("<label class='control-label col-sm-2 ' style='text-align: right; font-size: 12px;'>AMC To*</label>")
            strHTML.Append("<div class='col-sm-8' style='display:inline-flex' >")
            strHTML.Append("<div>")
            strHTML.Append("<input type='text' value='" & strAMCTo & "'  class='form-control' id='dtAMCTo' placeholder=''>")

            strHTML.Append("</div>")
            strHTML.Append("<div>")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtAMCTo').datepicker({orientation: 'right top'});$('#dtAMCTo').datepicker('show');""></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' >")
            strHTML.Append("<label class='control-label col-sm-2 ' style='text-align: right; font-size: 12px;'>AMC Due Date*</label>")
            strHTML.Append("<div class='col-sm-8' style='display:inline-flex' >")
            strHTML.Append("<div>")
            strHTML.Append("<input type='text' value='" & strAMCDueDate & "'  class='form-control'chkIsCurrentVersion id='dtAMCDueDate' placeholder=''>")

            strHTML.Append("</div>")
            strHTML.Append("<div>")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtAMCDueDate').datepicker({orientation: 'right top'});$('#dtAMCDueDate').datepicker('show');""></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' >")
            strHTML.Append("<label class='control-label col-sm-2 ' style='text-align: right; font-size: 12px;'>Product Validity*</label>")
            strHTML.Append("<div class='col-sm-8' style='display:inline-flex' >")
            strHTML.Append("<div>")
            strHTML.Append("<input type='text' value='" & strProductValidity & "'  class='form-control' id='dtProductValidity' placeholder=''>")

            strHTML.Append("</div>")
            strHTML.Append("<div>")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtProductValidity').datepicker({orientation: 'right top'});$('#dtProductValidity').datepicker('show');""></i>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Currency* </label>")
            strHTML.Append("<div class='col-sm-8'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", "usp_NG2_SEL_Tbl_PM_CurrencyMaster ", 300, strCurrency, "", True, True, "form-control"))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("NonDatabase1", "usp_sel_FromToDatesForAMC " & CustomerProductVersionID, 300, strCurrency, "", True, True, "form-control", , , True, ))


            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> AMC Amount* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAMCAmount", "txtAMCAmount", "form-control", , 15, strAMCAmount, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Responsible Person*  </label>")
            strHTML.Append("<div class='col-sm-8'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResponsiblePerson", "usp_NG2_Sel_tbl_PM_EmployeeReportingTo ", 300, strResponsiblePerson, "'", True, True, "form-control"))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Description </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAMCDescription", "txtAMCDescription", , "form-control", , , , , 208, 56, , strDescription, , "  class='form-control' placeholder='Enter Description' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
            strHTML.Append("<div class='right'>")
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick=SaveAMCDetails('" & UniqueID & "') style='background-color: #343660; color: #ffffff' >Save</button>")
            strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_AMC()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff'>Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveAMCDetails(ByVal CustomerProductVersionID As String, ByVal UniqueID As String, ByVal AMCFrom As String, ByVal AMCTo As String, ByVal DueDate As String, ByVal ProductValidity As String, ByVal Currency As String, ByVal Amount As String, ByVal ResponsiblePerson As String, ByVal Description As String)
        '=====================================================================
        ' Procedure  Name		:	SaveAMCDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update AMC details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim strResult As String = "0"

        Dim strSQl As String = "usp_NG2_Ins_Tbl_PRD_Customer_ProductVersion_AMC " & CustomerProductVersionID
        If (UniqueID <> "" And UniqueID <> "0") Then
            strSQl += "," & UniqueID
        Else
            strSQl += ",NULL"
        End If

        strSQl += ",'" & AMCFrom & "'"
        strSQl += ",'" & AMCTo & "'"
        strSQl += ",'" & DueDate & "'"
        strSQl += ",'" & ProductValidity & "'"
        strSQl += "," & Currency & ""
        strSQl += "," & Amount & ""
        strSQl += "," & ResponsiblePerson & ""
        strSQl += ",'" & Description & "'"
        strSQl += ",'" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'"

        Try
            CommonFunction.Data.InsertOrUpdateData(strSQl, True)
            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshAMCGrid(CustomerProductVersionID)
        '=====================================================================
        ' Procedure  Name		:	RefreshAMCGrid
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Refresh Product Version Grid
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim objProductCust As New CRM_CustomerProductExecution()
        Try
            strHTML.Append(objProductCust.AMCDetails(CustomerProductVersionID))
            Return strHTML.ToString
        Catch ex As Exception

            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetLicenseDetails(ByVal LicenseID As String, ByVal CustomerProductVersionID As String)
        '=====================================================================
        ' Procedure  Name		:	GetLicenseDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:    To get License details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Try

            Dim strHTML As New StringBuilder("")
            Dim strSQL As String = "usp_NG2_Tbl_PRD_Customer_ProductVersion_License " & CustomerProductVersionID & "," & LicenseID
            Dim strReferenceCode As String = ""

            Dim strReferenceDate As String = ""
            Dim strQuantity As String = ""
            Dim strPriceUnit As String = ""
            Dim strCurrency As String = ""
            Dim strPricePerUnit As String = ""
            Dim strDiscount As String = ""
            Dim strDiscription As String = ""

            Dim drLicense As IDataReader

            If LicenseID <> "" Then
                drLicense = CommonFunction.Data.GetDataReader(strSQL, True)
                If drLicense.Read Then


                    strReferenceCode = CommonFunction.Data.CheckIsDBNull(drLicense("ReferenceCode"), "")
                    strReferenceDate = CommonFunction.Data.CheckIsDBNull(drLicense("RefernceDate"), "")
                    strQuantity = CommonFunction.Data.CheckIsDBNull(drLicense("Quantity"), "")
                    strPriceUnit = CommonFunction.Data.CheckIsDBNull(drLicense("PriceUnitID"), "")
                    strCurrency = CommonFunction.Data.CheckIsDBNull(drLicense("CurrencyID"), "")
                    strPricePerUnit = CommonFunction.Data.CheckIsDBNull(drLicense("PricePerUnit"), "")
                    strDiscount = CommonFunction.Data.CheckIsDBNull(drLicense("DiscountPercent"), "")
                    strDiscription = CommonFunction.Data.CheckIsDBNull(drLicense("Description"), "")

                End If
            End If

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Reference Code </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReferenceCode", "txtReferenceCode", "form-control", , 15, strReferenceCode, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' >")
            strHTML.Append("<label class='control-label col-sm-2 ' style='text-align: right; font-size: 12px;'>Reference Date*</label>")
            strHTML.Append("<div class='col-sm-8' style='display:inline-flex' >")
            strHTML.Append("<div>")
            strHTML.Append("<input type='text' value='" & strReferenceDate & "'  class='form-control' id='dtReference' placeholder=''>")

            strHTML.Append("</div>")
            strHTML.Append("<div>")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtReference').datepicker({orientation: 'right top'});$('#dtReference').datepicker('show');""></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Quantity* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtLicenseQuantity", "txtLicenseQuantity", "form-control", , 15, strQuantity, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")



            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Price Unit* </label>")
            strHTML.Append("<div class='col-sm-8'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriceUnitLicense", "Usp_sel_tbl_PRD_PriceUnit ", 300, strPriceUnit, "", True, True, "form-control"))

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Currency* </label>")
            strHTML.Append("<div class='col-sm-8'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCurrencyLicense", "usp_NG2_SEL_Tbl_PM_CurrencyMaster ", 300, strCurrency, "", True, True, "form-control"))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Price Per Unit* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPricePerUnitLicense", "txtPricePerUnitLicense", "form-control", , 15, strPricePerUnit, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Discount %* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDiscountLicense", "txtDiscountLicense", "form-control", , 15, strReferenceCode, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Description </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtLicenseDescription", "txtLicenseDescription", , "form-control clstxtArea", , , , , 208, 56, , strDiscription, , "  class='form-control' placeholder='Enter Description' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
            strHTML.Append("<div class='right'>")
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick=SaveLicenseDetails('" & LicenseID & "') style='background-color: #343660; color: #ffffff' >Save</button>")
            strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_License()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff' >Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</form>")
            strHTML.Append("</div>")

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"

        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveLicenseDetails(ByVal CustomerProductVersionID As String, ByVal LicenseID As String, ByVal ReferenceCode As String, ByVal Referencedate As String, ByVal Quantity As String, ByVal PriceUnit As String, ByVal PricePerUnit As String, ByVal Currency As String, ByVal Discount As String, ByVal Description As String)
        '=====================================================================
        ' Procedure  Name		:	SaveLicenseDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update License details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim strResult As String = "0"

        Dim strSQl As String = "usp_NG2_Ins_Upd_Tbl_PRD_Customer_ProductVersion_License " & CustomerProductVersionID
        If (LicenseID <> "" And LicenseID <> "0") Then
            strSQl += "," & LicenseID
        Else
            strSQl += ",NULL"
        End If

        strSQl += ",'" & ReferenceCode & "'"
        strSQl += ",'" & Referencedate & "'"
        strSQl += "," & Quantity & ""
        strSQl += "," & PriceUnit & ""
        strSQl += "," & Currency & ""
        strSQl += "," & PricePerUnit & ""
        strSQl += "," & Discount & ""
        strSQl += ",'" & Description & "'"
        strSQl += ",'" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'"

        Try
            CommonFunction.Data.InsertOrUpdateData(strSQl, True)
            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshLicenseGrid(CustomerProductVersionID)
        '=====================================================================
        ' Procedure  Name		:	RefreshLicenseGrid
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim objProductCust As New CRM_CustomerProductExecution()
        Try
            strHTML.Append(objProductCust.LicensesDetails(CustomerProductVersionID))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetReleaseDetails(ByVal ReleaseID As String, ByVal CustomerProductVersionID As String)
        '=====================================================================
        ' Procedure  Name		:	GetReleaseDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:    To get License details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim strSQL As String = "usp_NG2_SEL_tbl_PRD_Release " & CustomerProductVersionID & "," & ReleaseID



            Dim strSubject As String = ""
            Dim strRelaseDate As String = ""
            Dim strObjectives As String = ""

            Dim strReleaseItems As String = ""
            Dim strKnownProblems As String = ""
            Dim strIssues As String = ""
            Dim strTestingSummary As String = ""

            Dim strInstallation As String = ""
            strRelaseDate = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT CAST(GETDATE() As date )", True), "")

            Dim drLicense As IDataReader

            If ReleaseID <> "" Then
                drLicense = CommonFunction.Data.GetDataReader(strSQL, True)
                If drLicense.Read Then


                    strSubject = CommonFunction.Data.CheckIsDBNull(drLicense("Subject"), "")
                    strObjectives = CommonFunction.Data.CheckIsDBNull(drLicense("Objectives"), "")
                    strReleaseItems = CommonFunction.Data.CheckIsDBNull(drLicense("Details"), "")
                    strKnownProblems = CommonFunction.Data.CheckIsDBNull(drLicense("KnownProblems"), "")
                    strIssues = CommonFunction.Data.CheckIsDBNull(drLicense("Issues"), "")
                    strTestingSummary = CommonFunction.Data.CheckIsDBNull(drLicense("TestingSummary"), "")
                    strInstallation = CommonFunction.Data.CheckIsDBNull(drLicense("Installation"), "")

                End If
            End If

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2 '  style='text-align: right;font-size: 11px'> Subject* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelaseSubject", "txtRelaseSubject", "form-control", , 15, strSubject, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' >")
            strHTML.Append("<label class='control-label col-sm-2 ' style='text-align: right; font-size: 12px;'>Release Date</label>")
            strHTML.Append("<div class='col-sm-8' style='display:inline-flex' >")
            strHTML.Append("<div>")
            strHTML.Append("<input type='text' value='" & strRelaseDate & "'  disabled class='form-control' id='dtreleasedate' placeholder=''>")

            strHTML.Append("</div>")
            strHTML.Append("<div>")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtreleasedate').datepicker({orientation: 'right top'});$('#dtreleasedate').datepicker('show');""></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")



            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Objectives* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtObjectives", "txtObjectives", , "form-control clstxtArea", , , , , 208, 56, , strObjectives, , "  class='form-control' placeholder='' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Details about release items* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReleaseItems", "txtReleaseItems", , "form-control clstxtArea", , , , , 208, 56, , strReleaseItems, , "  class='form-control' placeholder='' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Known Problems* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtKnownProblems", "txtKnownProblems", , "form-control clstxtArea", , , , , 208, 56, , strKnownProblems, , "  class='form-control' placeholder='' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Issues* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRelaseIssues", "txtRelaseIssues", , "form-control clstxtArea", , , , , 208, 56, , strIssues, , "  class='form-control' placeholder='' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Testing Summary </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txttestingsummary", "txttestingsummary", , "form-control clstxtArea", , , , , 208, 56, , strTestingSummary, , "  class='form-control' placeholder='' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")



            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Installation </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtinstallation", "txtinstallation", , "form-control clstxtArea", , , , , 208, 56, , strInstallation, , "  class='form-control' placeholder='' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")



            strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
            strHTML.Append("<div class='right'>")
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick=SaveReleaseDetails('" & ReleaseID & "') style='background-color: #343660; color: #ffffff' >Save</button>")
            strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Release()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff' >Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</form>")
            strHTML.Append("</div>")

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SavereleaseDetails(ByVal CustomerProductVersionID As String, ByVal ReleaseID As String, ByVal Subject As String, ByVal Objectives As String, ByVal ReleaseItems As String, ByVal KnowmProblems As String, ByVal Issues As String, ByVal TestingSummary As String, ByVal Installation As String)
        '=====================================================================
        ' Procedure  Name		:	SavereleaseDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update Relase details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim strResult As String = "0"

        Dim strSQl As String = "usp_NG2_Ins_Upd_tbl_PRD_Release " & CustomerProductVersionID
        If (ReleaseID <> "" And ReleaseID <> "0") Then
            strSQl += "," & ReleaseID
        Else
            strSQl += ",NULL"
        End If

        strSQl += ",'" & Subject & "'"
        strSQl += ",'" & Objectives & "'"
        strSQl += ",'" & ReleaseItems & "'"
        strSQl += ",'" & KnowmProblems & "'"
        strSQl += ",'" & Issues & "'"
        strSQl += ",'" & TestingSummary & "'"
        strSQl += ",'" & Installation & "'"
        strSQl += ",'" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'"

        Try
            CommonFunction.Data.InsertOrUpdateData(strSQl, True)
            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshReleaseGrid(CustomerProductVersionID)
        '=====================================================================
        ' Procedure  Name		:	RefreshReleaseGrid
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim objProductCust As New CRM_CustomerProductExecution()
        Try
            strHTML.Append(objProductCust.ReleasesDetails(CustomerProductVersionID))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteProduct(ByVal ProductIDs As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteProduct
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete customer product
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim drProduct As IDataReader
        Dim strResult = ""
        strSQL = "usp_NG2_Del_tbl_PRD_Customer_ProductVersion '" & ProductIDs & "'"

        Try
            drProduct = CommonFunctions.Data.GetDataReader(strSQL, True)
            If (drProduct.Read) Then
                strResult = drProduct("Result")
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteModuleComponent(ByVal ProductIDs As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteProduct
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete customer product
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim drProduct As IDataReader
        Dim strResult = ""
        strSQL = "usp_NG2_DEL_tbl_PRD_Customer_ProductVersion_Components '" & ProductIDs & "'"

        Try
            drProduct = CommonFunctions.Data.GetDataReader(strSQL, True)
            If (drProduct.Read) Then
                strResult = drProduct("Result")
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshComponentDetails(CustomerProductVersionID)
        '=====================================================================
        ' Procedure  Name		:	RefreshComponentDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim objProductCust As New CRM_CustomerProductExecution()
        Try
            strHTML.Append(objProductCust.ComponentDetails(CustomerProductVersionID))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AMCDelete(ByVal ProductIDs As String)
        '=====================================================================
        ' Procedure  Name		:	AMCDelete
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete customer product
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim drProduct As IDataReader
        Dim strResult = ""
        strSQL = "usp_NG2_Del_tbl_PRD_Customer_ProductVersion_AMC '" & ProductIDs & "'"

        Try
            drProduct = CommonFunctions.Data.GetDataReader(strSQL, True)
            If (drProduct.Read) Then
                strResult = drProduct("Result")
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    
    <System.Web.Services.WebMethod()>
    Public Shared Function LicenseDelete(ByVal ProductIDs As String)
        '=====================================================================
        ' Procedure  Name		:	LicenseDelete
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete customer product
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim drProduct As IDataReader
        Dim strResult = ""
        strSQL = "usp_NG2_Del_Tbl_PRD_Customer_ProductVersion_License '" & ProductIDs & "'"

        Try
            drProduct = CommonFunctions.Data.GetDataReader(strSQL, True)
            If (drProduct.Read) Then
                strResult = drProduct("Result")
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ReleaseDelete(ByVal ProductIDs As String)
        '=====================================================================
        ' Procedure  Name		:	ReleaseDelete
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete customer product
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim drProduct As IDataReader
        Dim strResult = "0"
        strSQL = "usp_NG2_del_tbl_PRD_Release '" & ProductIDs & "'"

        Try
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            strResult = "1"

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
End Class