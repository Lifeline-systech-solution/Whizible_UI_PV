Public Class CRM_Product_Line
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objProductGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As WebPages.Template.GenericGrid

    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected TagID As String = ""
    Protected m_intRoleID As Integer = 0
    Protected strLoginType = ""
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
        ' Created               :	05-jaN
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
        ' Created               :05-JAN-2017
        ' Revisions             : None
        '=====================================================================

        Dim strHTML As New StringBuilder("")
        strHTML.Append(DrawFilter(strflag))
        strHTML.Append("<div class='table-responsive' id='divProductLine'>")
        strHTML.Append(DrawGrid())
        strHTML.Append("</div>")

        ''Grid Plotting End
        ''Collapse Button Start
        strHTML.Append("<div class='bottom-bar' id='divSubTypeBottom edit_target'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'>Add Product Line </span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class='' id='Addaccordion'><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        strHTML.Append(ProductLineDetails("", strflag))
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
    Protected Function ProductLineDetails(Optional ByVal ProductLineId As String = "", Optional ByVal strFlag As String = "")
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = "usp_NG2_SEL_Tbl_PRD_ProductLine " & ProductLineId
        Dim strProductLineCode As String = ""
        Dim strProductLine As String = ""
        Dim strDescrition As String = ""
        Dim drProduct As IDataReader

        drProduct = CommonFunction.Data.GetDataReader(strSQL, True)
        If drProduct.Read Then

            If ProductLineId <> "" Then
                strProductLineCode = CommonFunction.Data.CheckIsDBNull(drProduct("ProductLineCode"), "")
                strProductLine = CommonFunction.Data.CheckIsDBNull(drProduct("ProductLine"), "")
                strDescrition = CommonFunction.Data.CheckIsDBNull(drProduct("Description"), "")

            End If
        End If
        strHTML.Append("<div class='panel-body' style='height: 250px;'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Product Line Code* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtProductLineCode", "txtProductLineCode", "form-control", 200, 50, strProductLineCode, , , , , , , " class='form-control'  placeholder='Enter Product Line Code' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Product Line* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtProductLine", "txtProductLine", "form-control", 200, 100, strProductLine, , , , , , , " class='form-control'  placeholder='Enter Product Line' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")

        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Description </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , 208, 56, , strDescrition, , "  class='form-control' placeholder='Enter Description' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        '/*Added By Yasmin on 27th july 2018*/


        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right' style='margin-right: -15px;'>")
        If strFlag <> "" Then
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveProductLine()' style='background-color: #343660; color: #ffffff'>Save</button>")
            strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks' onclick='SaveAndProductLine()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff' >Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        Else
            If m_objAccess.Add = True Or m_objAccess.Edit = True Then
                strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveProductLine()' style='background-color: #343660; color: #ffffff'>Save</button>")
                strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks' onclick='SaveAndProductLine()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
            End If

        End If
        If ProductLineId <> "" Then
            strHTML.Append("<button type='button' id='History' class='btn btn-default save clsbuttonLinks' onclick='ShowHistory_OnClick()' style=' margin-left: 5px; background-color: #343660; color: #ffffff'>Show History</button>")
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
        '/*Changed By Yasmin on 25th july 2018*/

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar' id='ProductFilter'>")

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
                strHTML.Append("<button type='button' class='btn btn-default' onclick='AddProductLine()' title='Add Product '>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
                strHTML.Append("</li>")
            End If
            If m_objAccess.Delete = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append(" <button type='button' class='btn btn-default' title='Delete Product' onclick='DeleteProductLine()' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                strHTML.Append("</li>")
            End If
        Else

            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button type='button' class='btn btn-default' onclick='AddProductLine()'  title='Add Product'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")


            strHTML.Append("<li class='clearall'>")
            strHTML.Append(" <button type='button' class='btn btn-default' title='Delete Product' onclick='DeleteProductLine()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")

        End If
        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function DrawGrid() As String
        '=====================================================================
        ' Procedure Name        : DrawGrid()
        ' Purpose               : To Plot product  grid
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
        strDivID = "divProductLineGrid"
        strSQLQuery = "usp_NG2_SEL_Tbl_PRD_ProductLine "

        arrstrActualList = {"ProductLineCode", "ProductLine", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Product Line Code", "Product Line", "Edit", "Delete"}

        arrstrLinkArray = {"", "", ""}
        arrCheckBoxArray = {"", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center"}
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
    Private Sub m_objProductGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objProductGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'   title='Edit Product Details'><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""ProductLine_OnClick(" & Args.DataReader("ProductLineId") & ")""   id='Editdata_" & Args.DataReader("ProductLineId") & "'></i></td>"



        End If

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Product'><input type=checkbox id=chkProductDelete name=chkProductDelete onclick='select_checkbox(this)'  value=" & Args.DataReader("ProductLineId") & " >" + "</TD>"

        End If


    End Sub
    Private Sub m_objProductGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objProductGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteMultiple_Product()' type=checkbox id=chkAllProduct name=chkAllProduct title='Select All'/></th>"
        End If


    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function PlotProductLineDetails(ByVal ProductLineID As String)
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
        Try
            Dim objProductLine As New CRM_Product_Line()
            Dim strHTML As New StringBuilder("")


            strHTML.Append(objProductLine.ProductLineDetails(ProductLineID, "1"))

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
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
            Dim objProductLine As New CRM_Product_Line()

            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

            strGridHTML.Append(objProductLine.WritePage("1"))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveProductLine(ByVal ProdcutLineID As String, ByVal ProductLineCode As String, ByVal ProductLine As String, ByVal Description As String)
        '=====================================================================
        ' Procedure  Name		:	SaveProductLine
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	save productline Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:  05-Jan-2017
        '=====================================================================
        Try
            Dim strSQL As String
            Dim strFlag As String = ""



            strSQL = "usp_Ins_Upd_Tbl_PRD_ProductLine '" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName")) & "',"


            If ProdcutLineID = "" Then

                strSQL += "NULL,"
            Else
                strSQL += ProdcutLineID & ","
            End If
            strSQL += "'" & ProductLine & "',"
            strSQL += "'" & ProductLineCode & "',"
            strSQL += "'" & Description & "'"




            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strFlag = "1"
            Return strFlag
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDuplicate(ByVal ProductLineCode As String, ByVal ProductLine As String) As String
        '=====================================================================
        ' Procedure  Name		:	CheckDuplicate
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To check duplicate Product line
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:  05-Jan-2017
        '=====================================================================
        Dim strSQL As String = "usp_NG2_CheckDuplicate_ProductLine '" & ProductLineCode & "','" & ProductLine & "'"
        Dim drProduct As IDataReader
        Dim strFlagProdcutLine As String = ""
        Dim strFlagProductLineCode As String = ""
        Try


            drProduct = CommonFunction.Data.GetDataReader(strSQL, True)
            If drProduct.Read Then
                strFlagProdcutLine = CommonFunction.Data.CheckIsDBNull(drProduct("ProductLine"))
                strFlagProductLineCode = CommonFunction.Data.CheckIsDBNull(drProduct("ProductLineCode"))
            End If
        Catch ex As Exception
            drProduct.Dispose()
        End Try
        Return strFlagProdcutLine & "||" & strFlagProductLineCode
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteProductLine(ByVal ProductIDs As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteProductLine
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
            Dim strSQL As String = ""
            Dim drProduct As IDataReader
            Dim strResult = ""
            strSQL = "usp_NG2_Del_Tbl_PRD_ProductLine '" & ProductIDs & "'"


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
    Public Shared Function ShowHistory(ByVal UniqueID As Integer)
        '*******************************************************************************'
        ' Function Name	        :	Show Product line History                   '
        ' Purpose				:                 '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                : Yogesh Jalamkar                          '
        '*******************************************************************************'
        Try
            Dim strHTML As New StringBuilder("")
            Dim objProductLine As New CRM_Product_Line()
            Dim strSQLQuery As String = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 3693,'" & UniqueID & "'"
            strHTML.Append(objProductLine.ShowHistoryGrid(UniqueID, strSQLQuery))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function FilteredHistory(ByVal newModifiedField As String, ByVal UniqueID As Integer, ByVal newModifiedBy As String)
        '================================================================================
        ' Procedure Name        : FilteredHistory()	
        ' Purpose               : Get product line details for selected filter
        ' Description           : Get Email setting details for selected filter
        ' Parameters Passed     : newModifiedField
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Yogesh Jalamkar
        ' Created               : 10-Jan-2018
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            Dim objProductLine As New CRM_Product_Line()
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "Main" Then
                newModifiedField = "null"
            End If

            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 3693, '" & UniqueID & "','" & newModifiedField & "','" & newModifiedBy & "'"
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objProductLine.ShowHistoryGrid(UniqueID, strSQL))

            Return strHTML.ToString()

        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
    Public Function ShowHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	Show Product line History                   '
        ' Purpose				:                 '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                : Yogesh Jalamkar                          '
        '*******************************************************************************'
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


        Dim m_objGridHistory As New WebPages.Template.GenericGrid

        intNoOfDataColumn = 4
        strDivID = "ShowHistoryGrid"


        arrstrActualList = {"Date", "FieldName", "ModifiedBy", "Value"}
        arrstrUserFriendlyList = {"Modified Date", "Field Modified", "Modified By", "Value"}

        arrstrLinkArray = {"", "", "", ""}
        arrCheckBoxArray = {"", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center"}
        m_objGridHistory = New WebPages.Template.GenericGrid
        If Flag = 0 Then
            With m_objGridHistory
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
                .SQL = storedprocedure
                .ColNameToolTipOnEachRow = False
                .UseSQL = True

                .returnHTML = True
                .IgnoreHTMLEncode = {"0"}
                strGridHTML.Append(.DrawGrid())
            End With

            'intRecordCount = m_objGridAttachment.NoOfRows

            m_objGridHistory = Nothing
        End If

        Return strGridHTML.ToString
    End Function
End Class