Public Class CRM_ProductMaster
    Inherits WebPages.Template.WhizTemplate

#Region "Member Declaration"
    Private WithEvents m_objProductGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected WithEvents objProductVersionGrid As WebPages.Template.GenericGrid
    Protected WithEvents objCompetitorGrid As WebPages.Template.GenericGrid
    Protected WithEvents objProductComponentGrid As WebPages.Template.GenericGrid

    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected TagID As String = "3694"
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
    Protected Function WritePage()
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
        strHTML.Append(DrawFilter())
        strHTML.Append("<div class='table-responsive' id='divProductMaster'>")
        strHTML.Append(DrawGrid())
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divSubTypeBottom'>")
        strHTML.Append(SubTagSection())
        strHTML.Append("</div>")

   
        CommonFunction.General.WriteHTML(strHTML.ToString)

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
        strHTML.Append("<label class='control-label ' style='text-align: right; font-size: 12px;'>Product Line</label>")
        strHTML.Append("<div class='' style='display:inline-flex;margin-left:5px' >")
        strHTML.Append("<div>")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboProductLineID", "usp_Sel_tbl_PRD_ProductLine ", 300, , "onChange='ProductLineOnChange(this)'", True, True, "form-control"))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")

        strHTML.Append("<ul class='right'>")
        If m_objAccess.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button type='button' class='btn btn-default' onclick='AddProduct()' title='Add Product'>Add<i class='fa fa-plus' aria-hidden='true'style='display:inline-block'></i></button>")
            strHTML.Append("</li>")
        End If
        If m_objAccess.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append(" <button type='button' class='btn btn-default' title='Delete Product' onclick='DeleteProduct()' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If

        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function DrawGrid(Optional ByVal ProductLineID As String = "") As String
        '=====================================================================
        ' Procedure Name        : DrawGrid()
        ' Purpose               : To Plot product  master
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
        strDivID = "divProductMasterGrid"
        If ProductLineID = "" Then
            strSQLQuery = "usp_NG2_Sel_Tbl_PRD_ProductMaster NULL,null"
        Else

            strSQLQuery = "usp_NG2_Sel_Tbl_PRD_ProductMaster NULL,'" & ProductLineID & "'"
        End If



        '/*Changed By Yasmin on 25th july 2018*/



        arrstrActualList = {"ProductLine", "Productcode", "Product", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Product Line", "Product Code", "Product", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center"}
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

            Args.StringToBeInserted = "<td align='center'   title='Edit Product Details'><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""ProductEdit_OnClick(" & Args.DataReader("ProductId") & ")""   id='Editdata_" & Args.DataReader("ProductId") & "'></i></td>"



        End If

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Product'><input type=checkbox id=chkProductDelete name=chkProductDelete  value=" & Args.DataReader("ProductId") & " >" + "</TD>"

        End If


    End Sub
    Private Sub objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteMultiple_Product()' type=checkbox id=chkAllProduct name=chkAllProduct title='Select All'/></th>"
        End If


    End Sub
    Protected Function SubTagSection(Optional ByVal ProductID As String = "") As String
        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'>Add Product </span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class='' id='Addaccordion'><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        strHTML.Append(ProductDetails(ProductID))
        strHTML.Append("</div>")
        If (ProductID <> "") Then


            strHTML.Append(GetTabs(ProductID))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString()
    End Function
    Protected Function ProductDetails(Optional ByVal ProductId As String = "")
        '=====================================================================
        ' Procedure  Name		:	ProductDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Plot Product details in edit mode
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = "usp_NG2_Sel_Tbl_PRD_ProductMaster " & ProductId

        Dim strProductCode As String = ""
        Dim strProduct As String = ""
        Dim strProductLine As String = ""
        Dim strDescription As String = ""
        Dim drProduct As IDataReader

        If ProductId <> "" Then
            drProduct = CommonFunction.Data.GetDataReader(strSQL, True)
            If drProduct.Read Then
                strProductLine = CommonFunction.Data.CheckIsDBNull(drProduct("ProductLineID"), "")
                strProductCode = CommonFunction.Data.CheckIsDBNull(drProduct("Productcode"), "")
                strProduct = CommonFunction.Data.CheckIsDBNull(drProduct("Product"), "")
                strDescription = CommonFunction.Data.CheckIsDBNull(drProduct("Description"), "")

            End If
        End If

        '/*Changed By Yasmin on 27th july 2018*/
        strHTML.Append("<div class='panel-body' style='height: 300px;'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")

        strHTML.Append("<div class='form-group'>")

        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Product Code*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtProductCode", "txtProductCode", "form-control", , 50, strProductCode, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append("<div class='form-group'>")

        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Product* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtProduct", "txtProduct", "form-control", , 200, strProduct, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Product Line* </label>")
        strHTML.Append("<div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProductLine", "usp_Sel_tbl_PRD_ProductLine ", , strProductLine, "", True, True, "form-control"))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")

        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Description </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , 56, , strDescription, , "  class='form-control' placeholder='Enter Description' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right'>")
        If (ProductId <> "") Then
            If m_objAccess.Add = True Or m_objAccess.Edit = True Then
                strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveProduct(" & ProductId & ")' style='background-color: #343660; color: #ffffff' >Save</button>")
            End If
        Else
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveProduct(" & ProductId & ")' style='background-color: #343660; color: #ffffff' >Save</button>")
        End If
      



        strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Product()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff' >Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Public Function GetTabs(Optional ByVal ProductId As String = "")
        Dim strGridHTML As New StringBuilder()
        Dim strTabHTML As New StringBuilder()
        strGridHTML.Append("<div class='col-sm-9' id='divTabs'>")
        strGridHTML.Append("<ul class='nav nav-tabs tablinks1' style='margin: 35px 0 22px 0;'>")




        GetSubTabAccessRights(3198, TagID)
        If m_objSubTabAccess.View = True Then
            strGridHTML.Append("<li class='active'><a data-toggle='tab' href='#ProductVersionDetails'>Add Product Version</a></li>")
            strTabHTML.Append("<div id='ProductVersionDetails' class='tab-pane fade in active bottom-bar'>")
            strTabHTML.Append("<div class='type-top-bar top-bar'>")
            If m_objSubTabAccess.Add = True Then
                strTabHTML.Append("<ul class='right'>")

                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button'  title='Add Product Version'  onclick='AddProductVersion_Onclick(" & ProductId & ")' class='btn btn-default' style='color:black!important;background-color:white!important'>Add<i class='fa fa-plus' aria-hidden='true'style='display:inline-block'></i></button></li>")
                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' class='btn btn-default' title='Delete Product Version' onclick='DeleteProductVersion_Onclick(" & ProductId & ")' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                strTabHTML.Append("</li>")
                strTabHTML.Append("</ul>")
            End If
            strTabHTML.Append("</div>")
            strTabHTML.Append(ProductVersionGrid(ProductId))
            ''''''''''''''
            strTabHTML.Append(" <div class='pannel-section'>")
            strTabHTML.Append("<div class='col-md-12 col-sm-12'>")

            strTabHTML.Append("<div class='panel-group wrap' id='accordionProductVersion' role='tablist' aria-multiselectable='true'>")
            strTabHTML.Append("<div class='panel'>")
            strTabHTML.Append("<div class='panel-heading' role='tab' id='panelProductVersionAdd' style='width: 99%;'>")
            strTabHTML.Append("<h3 style='font-size: 13px;'><span>Product Version</span></h3>")
            strTabHTML.Append("<h4 class='panel-title'>")
            strTabHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOnePVersion' aria-expanded='true' aria-controls='collapseOne'>")
            strTabHTML.Append("<i class='fa fa-plus' title='Expand' ></i>")
            strTabHTML.Append("<i class='fa fa-minus' title='Hide' ></i>")
            strTabHTML.Append("</a>")
            strTabHTML.Append("</h4>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("<div id='collapseOnePVersion' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
            strTabHTML.Append("<div class='panel-body' id='panelProductVersion'>")








            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("</div>")
            '''''''''''''''''''''
            strTabHTML.Append("</div>")
        End If

        GetSubTabAccessRights(3199, TagID)
        If m_objSubTabAccess.View = True Then

            strGridHTML.Append("<li class=''><a data-toggle='tab' href='#ProductCompetitor'>Product Competitor</a></li>")
            strTabHTML.Append("<div id='ProductCompetitor' class='tab-pane fade in  bottom-bar'>")
            strTabHTML.Append("<div class='type-top-bar top-bar'>")

            If m_objSubTabAccess.Add = True Then
                strTabHTML.Append("<ul class='right'>")
                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button'  title='Add Product Competitor' onclick=CompetitorEdit_OnClick('') class='btn btn-default' style='color:black!important;background-color:white!important'>Add<i class='fa fa-plus' aria-hidden='true'style='display:inline-block'></i></button></li>")

                strTabHTML.Append("<li class='clearall'>")
                strTabHTML.Append("<button type='button' class='btn btn-default' title='Delete Product Competitor' onclick='CompetitorDelete_Onclick(" & ProductId & ")' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                strTabHTML.Append("</li>")
                strTabHTML.Append("</ul>")
            End If
            strTabHTML.Append("</div>")
            strTabHTML.Append(CompetitorGrid(ProductId))

            strTabHTML.Append(" <div class='pannel-section'>")
            strTabHTML.Append("<div class='col-md-12 col-sm-12'>")

            strTabHTML.Append("<div class='panel-group wrap' id='accordionCompetitor' role='tablist' aria-multiselectable='true'>")
            strTabHTML.Append("<div class='panel'>")
            strTabHTML.Append("<div class='panel-heading' role='tab' id='panelCompetitorAdd' style='width: 99%;'>")
            strTabHTML.Append("<h3 style='font-size: 13px;'><span>Product Competitor</span></h3>")
            strTabHTML.Append("<h4 class='panel-title'>")
            strTabHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseCompetitor' aria-expanded='true' aria-controls='collapseOne'>")
            strTabHTML.Append("<i class='fa fa-plus' title='Expand'></i>")
            strTabHTML.Append("<i class='fa fa-minus' title='Hide'></i>")
            strTabHTML.Append("</a>")
            strTabHTML.Append("</h4>")
            strTabHTML.Append("</div>")
            strTabHTML.Append("<div id='collapseCompetitor' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
            strTabHTML.Append("<div class='panel-body' id='panelCompetitor'>")








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
    Protected Function ProductVersionGrid(ByVal ProductId As String) As String
        '=====================================================================
        ' Procedure Name        : ProductVersionGrid()
        ' Purpose               : To Plot product version  grid
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
        strDivID = "divProductVersionGrid"
        strSQLQuery = "usp_NG2_Sel_Tbl_PRD_ProductVersion NULL, " & ProductId


        arrstrActualList = {"ProductVersionCode", "ProductVersion", "PriceUnit", "Select Module/Components", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Product Version Code", "ProductVersion", "Price Unit", "Select Module/Components", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center", "align=left"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objProductVersionGrid = m_objProductGrid
        If Flag = 0 Then
            With objProductVersionGrid
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
            objProductVersionGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function
    Private Sub objProductVersionGrid_ColumnHeaderTH_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objProductVersionGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='SelectAll_ProductVersion(this)' type=checkbox id=chkAllProductVersion name=chkAllProductVersion title='Select All'/></th>"
        End If


    End Sub
    Private Sub objProductVersionGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objProductVersionGrid.DataRowTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Product'><input type=checkbox id=chkProductVersion name=chkProductVersion   value=" & Args.DataReader("ProductVersionID") & " >" + "</TD>"

        End If
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'   title='Edit Product Version Details' ><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""ProductVersionEdit_OnClick(" & Args.DataReader("ProductVersionID") & ")""  id='EditProductVersion_" & Args.DataReader("ProductVersionID") & "'></i></td>"

        End If
        If Args.ColumnName.ToUpper = "SELECT MODULE/COMPONENTS" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><a href=# style='text-decoration:underline!important'class='clsselectmodule' onclick=""SelectModuleComponent_Onclick(" & Args.DataReader("ProductVersionID") & ")""  title='' id='SelectProduct_" & Args.DataReader("ProductVersionID") & "'>Select Module/Components</a></td>"

        End If

    End Sub
    Protected Function CompetitorGrid(ByVal ProductId As String) As String
        '=====================================================================
        ' Procedure Name        : CompetitorGrid()
        ' Purpose               : To Plot CompetitorvGrid 
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
        strDivID = "divCompetitorGrid"
        strSQLQuery = "usp_sel_NG2_tbl_prd_productCompetitior NULL," & ProductId


        arrstrActualList = {"Competitor", "ListPrice", "PriceUnit", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Competitor", "List Price", "Price Unit", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center", "align=left"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        objCompetitorGrid = m_objProductGrid
        If Flag = 0 Then
            With objCompetitorGrid
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
            objCompetitorGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function
    Private Sub objCompetitorGrid_ColumnHeaderTH_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objCompetitorGrid.ColumnHeaderTD_BeforePrint

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='SelectAll_Competitor(this)' type=checkbox id=chkAllCompetitor name=chkAllCompetitor title='Select All'/></th>"
        End If


    End Sub
    Private Sub objCompetitorGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objCompetitorGrid.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Product Competitor'><input type=checkbox id=chkCompetitor name=chkCompetitor   value=" & Args.DataReader("ProductCompetitiorId") & " >" + "</TD>"

        End If
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'   title='Edit Product Competitor'><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""CompetitorEdit_OnClick(" & Args.DataReader("ProductCompetitiorId") & ")""  id='EditCompetitior_" & Args.DataReader("ProductCompetitiorId") & "'></i></td>"

        End If

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function PlotProductDetails(ByVal ProductID As String)
        '=====================================================================
        ' Procedure  Name		:	PlotProductDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Plot Product details in edit mode
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim objProduct As New CRM_ProductMaster()
            Dim strHTML As New StringBuilder("")
            objProduct.TagID = "3694"
            objProduct.m_intRoleID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0), Integer)
            objProduct.strLoginType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), 0)
            objProduct.GetAccessRights()

            strHTML.Append(objProduct.SubTagSection(ProductID))

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshGrid(ProductLineID)
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
        Try
            Dim strHTML As New StringBuilder()
            Dim objProduct As New CRM_ProductMaster()

            strHTML.Append(objProduct.DrawGrid(ProductLineID))

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDuplicates(ByVal strProduct As String, ByVal strProductCode As String)
        '=====================================================================
        ' Procedure  Name		:	CheckDuplicates values
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
        Try
            Dim strHTML As New StringBuilder()
            Dim strSQL As String
            strSQL = "usp_NG2_Check_Is_Product_ProductCode_Exists '" & strProduct & "','" & strProductCode & "'"
            Dim drProduct As IDataReader
            Dim strFlagProduct As String = ""
            Dim strFlagProductCode As String = ""

            drProduct = CommonFunction.Data.GetDataReader(strSQL, True)

            If drProduct.Read Then
                strFlagProduct = CommonFunction.Data.CheckIsDBNull(drProduct("ISProductDuplicate"), "")
                strFlagProductCode = CommonFunction.Data.CheckIsDBNull(drProduct("ISProductCodeDuplicate"), "")
            End If

            Return strFlagProduct & "||" & strFlagProductCode
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveProductDetails(ByVal ProductID As String, ByVal Product As String, ByVal ProductCode As String, ByVal Description As String, ByVal ProductLineID As String)
        Try
            Dim strFlag As String = "0"
            Dim strSQL As String = "usp_NG2_Ins_Upd_Tbl_PRD_Product "



            If (ProductID = "" Or ProductID = "0") Then
                strSQL += "NULL"
            Else
                strSQL += ProductID
            End If
            strSQL += ",'" & Product & "'"
            strSQL += ",'" & ProductCode & "'"
            strSQL += ",'" & ProductLineID & "'"
            strSQL += ",'" & Description & "'"
            strSQL += ",'" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'"
            strFlag = CommonFunction.Data.GetDataScalar(strSQL, True)


            Return strFlag
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AddProduct()
        Try
            Dim objProduct As New CRM_ProductMaster()
            Dim strHTML As New StringBuilder()
        strHTML.Append(objProduct.SubTagSection())
        Return strHTML.ToString()
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetProductVersion(ByVal ProductVersionID As String)
        '=====================================================================
        ' Procedure  Name		:	GetProductVersion
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:   To get product version details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim strSQL As String = "usp_NG2_Sel_Tbl_PRD_ProductVersion " & ProductVersionID
            Dim strProductVersionCode As String = ""
            Dim strProductVersion As String = ""
            Dim strDescription As String = ""
            Dim strPriceUnit As String = ""
            Dim strListPrice As String = ""
            Dim strDiscountPer As String = ""

            Dim drProductVersion As IDataReader
            If (ProductVersionID <> "") Then
                drProductVersion = CommonFunction.Data.GetDataReader(strSQL, True)
                If drProductVersion.Read Then


                    strProductVersionCode = CommonFunction.Data.CheckIsDBNull(drProductVersion("ProductVersionCode"), "")
                    strProductVersion = CommonFunction.Data.CheckIsDBNull(drProductVersion("ProductVersion"), "")
                    strDescription = CommonFunction.Data.CheckIsDBNull(drProductVersion("Description"), "")
                    strPriceUnit = CommonFunction.Data.CheckIsDBNull(drProductVersion("PriceUnitID"), "").ToString()
                    strListPrice = CommonFunction.Data.CheckIsDBNull(drProductVersion("PricePerUnit"), "")
                    strDiscountPer = CommonFunction.Data.CheckIsDBNull(drProductVersion("DiscountPercentage"), "")




                End If
            End If
            strHTML.Append("<div class='panel-body' style='height: 250px;'>")
            strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")

            If (ProductVersionID <> "") Then
                strHTML.Append("<ul class='right'>")
                strHTML.Append("<li class='clearall'>")
                strHTML.Append("<button type='button'  onclick='AddComponent(" & ProductVersionID & ")' class='btn btn-default' style='color:black!important;background-color:white!important'>Add as Component.<i class='fa fa-plus' aria-hidden='true'style='display:inline-block'></i></button></li>")
                strHTML.Append("</ul>")
            End If


            strHTML.Append("<div class='form-group'>")

            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Product Version Code* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtProductVersionCode", "txtProductVersionCode", "form-control", , 50, strProductVersionCode, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Product Version* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtProductVersion", "txtProductVersion", "form-control", , 100, strProductVersion, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Description </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtProductVersionDescription", "txtProductVersionDescription", , "form-control", , , , , 208, 56, , strDescription, , "  class='form-control' placeholder='Enter Description' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Price Unit* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriceUnit", "Usp_sel_tbl_PRD_PriceUnit ", , strPriceUnit, "", True, True, "form-control"))
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> List Price* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtListPrice", "txtListPrice", "form-control", , 100, strListPrice, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("Rs. Indian Rupees</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Discount Percentage </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDiscountPer", "txtDiscountPer", "form-control", , 100, strDiscountPer, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("(0 - 100)</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
            strHTML.Append("<div class='right'>")
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick=SaveProductVersion('" & ProductVersionID & "') style='background-color: #343660; color: #ffffff' >Save</button>")
            strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_ProductVersion()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff' >Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'Commented and Added by Usha Pandit on 25 JAN 2018 for save issue
    '<System.Web.Services.WebMethod()>
    'Public Shared Function CheckProductVersionDuplicates(ByVal ProductVersion As String, ByVal ProductVersionCode As String)
    '    '=====================================================================
    '    ' Procedure  Name		:	CheckProductVersionDuplicates values
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	YOgesh Jalamkar
    '    ' Created				:   8 Dec 2017
    '    '=====================================================================

    '    Dim strHTML As New StringBuilder()
    '    Dim strSQL As String
    '    strSQL = "usp_NG2_Check_Is_ProductVersion_ProductVersionCode_Exists '" & ProductVersion & "','" & ProductVersionCode & "'"
    '    Dim drProduct As IDataReader
    '    Dim strFlagProductVersion As String = ""
    '    Dim strFlagProductVersionCode As String = ""

    '    drProduct = CommonFunction.Data.GetDataReader(strSQL, True)
    '    Try
    '        If drProduct.Read Then
    '            strFlagProductVersion = CommonFunction.Data.CheckIsDBNull(drProduct("ISProductVersionDuplicate"), "")
    '            strFlagProductVersionCode = CommonFunction.Data.CheckIsDBNull(drProduct("ISProductVersionCodeDuplicate"), "")
    '        End If
    '    Catch ex As Exception

    '    End Try
    '    Return strFlagProductVersion & "||" & strFlagProductVersionCode
    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckProductVersionDuplicates(ByVal ProductVersion As String, ByVal ProductVersionCode As String, ByVal Flag As String, ByVal ProductVersionID As String) As String
        '=====================================================================
        ' Procedure  Name		:	CheckProductVersionDuplicates values
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
        Try
            Dim strHTML As New StringBuilder()
            Dim strResult = "0"
            Dim strSQL As String

            If (ProductVersion = "") Then
                ProductVersion = "NULL"
            End If
            If (ProductVersionCode = "") Then
                ProductVersionCode = "NULL"
            End If
            If (ProductVersionID = "") Then
                ProductVersionID = "0"
            End If
            strSQL = "usp_NG2_Check_Is_ProductVersion_ProductVersionCode_Exists '" & ProductVersion & "','" & ProductVersionCode & "','" & Flag & "'," & ProductVersionID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'End of Added by Usha Pandit on 25 JAN 2018 for save issue
    'Commented and Added by Usha Pandit on 25 JAN 2018 for save issue
    '<System.Web.Services.WebMethod()>
    'Public Shared Function SaveProductversionDetails(ByVal ProductID As String, ByVal ProductVersionID As String, ByVal ProductVersion As String, ByVal ProductVersionCode As String, ByVal Description As String, ByVal PriceUnit As String, ByVal ListPrice As String, ByVal DiscountPercentage As String)
    '    Dim strFlag As String = "0"
    '    Dim strSQL As String = "usp_NG2_INS_UPD_Tbl_PRD_ProductVersion "
    '    Try

    '        strSQL += ProductID
    '        If (ProductVersionID = "" Or ProductVersionID = "0") Then
    '            strSQL += ",NULL"
    '        Else
    '            strSQL += "," & ProductVersionID
    '        End If
    '        strSQL += ",'" & ProductVersion & "'"
    '        strSQL += ",'" & ProductVersionCode & "'"
    '        strSQL += ",'" & Description & "'"
    '        strSQL += "," & PriceUnit
    '        strSQL += "," & ListPrice
    '        If (DiscountPercentage = "") Then
    '            strSQL += ",NULL"
    '        Else
    '            strSQL += "," & DiscountPercentage
    '        End If
    '        strSQL += ",'" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'"
    '        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    '        strFlag = "1"
    '    Catch ex As Exception

    '    End Try
    '    Return strFlag
    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveProductversionDetails(ByVal ProductID As String, ByVal ProductVersionID As String, ByVal ProductVersion As String, ByVal ProductVersionCode As String, ByVal Description As String, ByVal PriceUnit As String, ByVal ListPrice As String, ByVal DiscountPercentage As String)
        Try
            Dim strResult As String = "0"
            Dim strSQL As String = "usp_NG2_INS_UPD_Tbl_PRD_ProductVersion "


            strSQL += ProductID
            If (ProductVersionID = "" Or ProductVersionID = "0") Then
                strSQL += ",NULL"
            Else
                strSQL += "," & ProductVersionID
            End If
            strSQL += ",'" & ProductVersion & "'"
            strSQL += ",'" & ProductVersionCode & "'"
            strSQL += ",'" & Description & "'"
            strSQL += "," & PriceUnit
            strSQL += "," & ListPrice
            If (DiscountPercentage = "") Then
                strSQL += ",NULL"
            Else
                strSQL += "," & DiscountPercentage
            End If
            strSQL += ",'" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'"
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)



            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    'End of Added by Usha Pandit on 25 JAN 2018 for save issue

    <System.Web.Services.WebMethod()>
    Public Shared Function AddComponent(ByVal ProductVersionID As String)
        Try
            Dim strSQL As String = "usp_NG2_Upd_Tbl_PRD_ProductVersion_AddComponent " & ProductVersionID
            Dim strResult As String = "0"

        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strResult = "1"

            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetCompetitor(ByVal ProductCompetitiorId As String, ByVal ProductID As String)
        '=====================================================================
        ' Procedure  Name		:	GetCompetitor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:   To get Competitor version details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim strSQL As String = "usp_sel_NG2_tbl_prd_productCompetitior " & ProductCompetitiorId
            Dim strCompetitior As String = ""
            Dim strListPrice As String = ""
            Dim strPriceUnit As String = ""
            Dim drCompetitior As IDataReader
            If (ProductCompetitiorId <> "") Then
                drCompetitior = CommonFunction.Data.GetDataReader(strSQL, True)
                If drCompetitior.Read Then


                    strCompetitior = CommonFunction.Data.CheckIsDBNull(drCompetitior("CompetitorID"), "").ToString()
                    strListPrice = CommonFunction.Data.CheckIsDBNull(drCompetitior("ListPrice"), "").ToString()
                    strPriceUnit = CommonFunction.Data.CheckIsDBNull(drCompetitior("PriceUnitID"), "").ToString()





                End If
            End If
            strHTML.Append("<div class='panel-body' style='height: 250px;'>")
            strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")


            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Competitor* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            If (ProductCompetitiorId <> "") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCompetitor", "usp_NG2_SEL_tbl_rw_product_Competitior ", , strCompetitior, " disabled", True, True, "form-control"))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCompetitor", "usp_NG2_SEL_tbl_rw_product_Competitior " & ProductID, , strCompetitior, "", True, True, "form-control"))
            End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> List Price </label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtListPriceCompetitor", "txtListPriceCompetitor", "form-control", , 100, strListPrice, , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("Rs. Indian Rupees</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Price Unit*</label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriceUnit", "Usp_sel_tbl_PRD_PriceUnit ", , strPriceUnit, "", True, True, "form-control"))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
            strHTML.Append("<div class='right'>")
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick=SaveCompetitor('" & ProductCompetitiorId & "') style='background-color: #343660; color: #ffffff' >Save</button>")
            strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Competitor()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff'>Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveProductCompetitor(ByVal ProductID As String, ByVal ProductCompetitiorId As String, ByVal ListPriceCompetitor As String, ByVal strCompetitor As String, ByVal strcboPriceUnit As String)
        Try
            Dim strFlag As String = "0"
            Dim strSQL As String = "usp_NG2_INS_UPD_tbl_prd_productCompetitior "


            strSQL += ProductID
            If (ProductCompetitiorId = "" Or ProductCompetitiorId = "0") Then
                strSQL += ",NULL"
            Else
                strSQL += "," & ProductCompetitiorId
            End If
            strSQL += ",'" & ListPriceCompetitor & "'"
            strSQL += "," & strCompetitor & ""
            strSQL += "," & strcboPriceUnit & ""
            strSQL += ",'" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strFlag = "1"

            Return strFlag
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ProductLineChange(ByVal ProductLine As String)
        Try
            Dim objProduct As New CRM_ProductMaster()
            Dim strHTML As New StringBuilder("")

        strHTML.Append(objProduct.DrawGrid(ProductLine))
        Return strHTML.ToString()
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteProduct(ByVal ProductIDs As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteProduct
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete product
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
            Dim drProduct As IDataReader
            Dim strResult = ""
            strSQL = "usp_NG2_del_tbl_prd_product '" & ProductIDs & "'"


            drProduct = CommonFunctions.Data.GetDataReader(strSQL, True)
            If (drProduct.Read) Then
                strResult = drProduct("Result")
            End If


            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteProductVersion(ByVal ProductVersionIDs As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteProductVersion
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete product version
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
            Dim drProduct As IDataReader
            Dim strResult = ""
            strSQL = "usp_NG2_Del_tbl_PRD_ProductVersion '" & ProductVersionIDs & "'"


            drProduct = CommonFunctions.Data.GetDataReader(strSQL, True)
            If (drProduct.Read) Then
                strResult = drProduct("Result")
            End If


            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshProductVersionGrid(ProductID)
        '=====================================================================
        ' Procedure  Name		:	RefreshProductVersionGrid
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
        Try
            Dim strHTML As New StringBuilder()
            Dim objProduct As New CRM_ProductMaster()

            strHTML.Append(objProduct.ProductVersionGrid(ProductID))

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCompetitor(ByVal CompetitorIDs As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteCompetitor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete Competitor version
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:  05-JAN-2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
            Dim drProduct As IDataReader
            Dim strResult = "0"
            strSQL = "usp_NG2_Del_tbl_prd_productCompetitior '" & CompetitorIDs & "'"


            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strResult = "1"


            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshCompetitorGrid(ProductID)
        '=====================================================================
        ' Procedure  Name		:	RefreshProductVersionGrid
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
        Try
            Dim strHTML As New StringBuilder()
            Dim objProduct As New CRM_ProductMaster()

            strHTML.Append(objProduct.CompetitorGrid(ProductID))

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SelectProductComponent(ByVal ProductVersionID As String)
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
            Dim objCustomerProduct As New CRM_ProductMaster()
            strHTML.Append(objCustomerProduct.SelectProductComponentGrid(ProductVersionID))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    Protected Function SelectProductComponentGrid(ByVal ProductVersionID As String) As String
        '=====================================================================
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
        strDivID = "divProductComponentGrid"
        strSQLQuery = "usp_NG2_SEL_D_Tbl_PRD_ProductVersion_Component " & ProductVersionID


        arrstrActualList = {"ComponentType", "ComponentCode", "Component", "Select"}
        arrstrUserFriendlyList = {"Module/Component Type", "Module/Component Code", "Module/Component", "Select"}

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

                Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkProductDelete name=chkProductComponentSelect  checked  value=" & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ComponentID"), ""), String) & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkProductDelete name=chkProductComponentSelect    value=" & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ComponentID"), ""), String) & " >" + "</TD>"
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
    Public Shared Function SaveProductComponents(ByVal ProductVersionID As String, ByVal ProductComponentIDS As String)
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
        Try
            Dim strHTML As New StringBuilder()
            Dim strResult As String = "0"

            Dim strSQl As String = "USP_INS_Tbl_PRD_ProductVersion_Component " & ProductVersionID & ",'" & ProductComponentIDS & "'"

            CommonFunction.Data.InsertOrUpdateData(strSQl, True)
            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
End Class