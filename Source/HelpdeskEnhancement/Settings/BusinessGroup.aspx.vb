Public Class BusinessGroup
    Inherits WebPages.Template.WhizTemplate
    Private m_objSubTagGlobal As WebPages.Template.IGlobal
    Protected m_objSubTagAccess As WebPage.Templates.AccessRights
    Private m_objSubTagCLSQL As CommonEngines.CommonList.cSubTagCLSQL
    Private Shared m_objSubTabAccess As WebPage.Templates.AccessRights
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""
    Protected Shared strUserName As String = ""
    Protected Shared intUserID As Integer = 0
    Protected Shared TagID As String = 1265
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Private WithEvents m_objMainGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objOUGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objCustomerClientContactGrid As New WebPages.Template.GenericGrid
    Protected WithEvents m_objGrid1 As New WebPages.Template.GenericGrid

    Public txtSQLQuery As New System.Text.StringBuilder
    Public strSQLQuery As String
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=center width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("strUserName"), String)
        intUserID = CType(Session("intUserID"), Integer)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        intUserID = CType(Session("intUserID"), Integer)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
    End Sub
    Protected Function WritePage(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : WriteTabsControls()	
        ' Purpose               : To Plot the Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali Vekhande
        ' Created               : 8th Jan 2018
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div id='Type' class='tabcontent1 h-type clsSettingstabs'>")
        strHTML.Append(BussinessTabDetails(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")

        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetSubTabAccessRights(ByVal SubtagID As Integer, ByVal TagID As String)
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Sub Tag 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali
        ' Created               :	 8th Jan 2018
        ' Revisions             :
        '=====================================================================
        Try
            m_objSubTabAccess = New WebPage.Templates.AccessRights
            Dim objGlobal As New WebPage.Templates.WhizGlobal(strUserName, SubtagID, m_intRoleID, intUserID, strLoginType, False, TagID)
            m_objSubTabAccess.GetAccess(objGlobal)
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

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
        ' Author                :	Dipali Vekhande
        ' Created               :	 8th Jan 2018
        ' Revisions             :
        '=====================================================================
        'If TagID = 0 Then
        '    TagID = 54
        'End If
        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

    End Sub
    ''Added by Usha Pandit on 21.05.2019 for refreshing OU drop down after adding new OU 
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetExistingOU()
        '=====================================================================
        ' Procedure  Name		:	Default_GetExistingOU
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Existing OUs
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   21 May 2019
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtProjects As DataTable
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_Sel_tbl_PM_Location_AddExisting ''"

            dtProjects = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtProjects)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function
    ''End of Added by Usha Pandit on 21.05.2019 for refreshing OU drop down after adding new OU 
    Public Function BussinessTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal BussinessID As String)
        '=====================================================================
        ' Procedure Name        : RequestTabDetails()	
        ' Purpose               : To Plot the Customer Master With Subtag
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali Vekhande
        ' Created               :  8th Jan 2018
        ' Revisions             : None
        '=====================================================================
        '/*Changed By Yasmin on 25th july 2018*/

        GetAccessRights()
        'TagID = 54
        Dim strHTML As New StringBuilder("")
        If strWhichGrid <> "PlotSubtab" And strWhichGrid <> "ClientContact" Then
            strHTML.Append("<div id='divTypeStatus'>")
            strHTML.Append("<div class='type-top-bar top-bar' id='divTypeTab'>")

            strHTML.Append("<ul class='left'>")
            strHTML.Append("<li class='search-bar'>")
            strHTML.Append("<div class='left search-bar'>")
            strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
            strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table' >")
            strHTML.Append("</div>")
            strHTML.Append("</li>")
            strHTML.Append("</ul>")

            strHTML.Append("<ul class='right'>")
            If m_objAccess.Add = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append("  <button type='button' onclick='AddBG()' class='btn btn-default' style='color:black!important;background-color:white!important' title='Add Business Group'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
            End If
            If m_objAccess.Delete = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append("    <button onclick='DeleteBG()' type='button' class='btn btn-default' title='Delete Business Group'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
            End If
            strHTML.Append("</ul>")
            strHTML.Append(" </div>")

            strHTML.Append("<div class='table-responsive' id='divRequestTypes'>")
            strHTML.Append(WriteRequestTabGrid("TYPE", strGridFlag, ""))
            strHTML.Append("</div>")

            strHTML.Append("<div class='bottom-bar' id='divTypeBottom'>")

            strHTML.Append("<div class='pannel-section'>")
            strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
            strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
            strHTML.Append(" <div class='panel'>")
            strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne'>")
            strHTML.Append("  <h4 class='panel-title'>")
            strHTML.Append("   <a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne' aria-expanded='true' aria-controls='collapseOne' id='Addaccordion'>")
            strHTML.Append(" <i class='fa fa-plus' title='Expand' style='color:white!important' id='plus' title='Expand'></i>")
            strHTML.Append("<i class='fa fa-minus' title='Hide' style='color:white!important' id='minus' title='Hide'></i>")
            strHTML.Append(" </a>")
            strHTML.Append(" </h4>")
            strHTML.Append("   <h3><span style='color:white'>Add New Business Group<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")

            strHTML.Append(" </div>")
            strHTML.Append(" <div id='collapseOne' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
            strHTML.Append(" <div class='panel-body' id='idPanelBody'>")
            strHTML.Append("<form class='form-horizontal' action='/action_page.php' enctype='multipart/form-data' method='post'>")

            strHTML.Append("<div class='form-group'>")
            'strHTML.Append("<div class='form-group'>")
            strHTML.Append(" <label class='control-label col-sm-3' for='request type'>Business Group Code*</label>")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("BussinessGroupCode", "BussinessGroupCode", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Business Group Code' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(" </div>")


            strHTML.Append(" <label class='control-label col-sm-3' for='request type'>Business Group Name*</label>")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("BussinessName", "BussinessName", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Business Group Name' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(" </div>")
            strHTML.Append("</div>")

            'strHTML.Append("  <label class='control-label col-sm-2' for='City' style='line-height: 1.2;' id='lblActive'>Active </label>")
            'strHTML.Append("  <div class='col-sm-4'>")
            'strHTML.Append(" <input type='checkbox' style='width:12px;' id='CheckActive'>")
            'strHTML.Append(" </div>")
            'strHTML.Append("</div>")


            '/*Changed By Yasmin on 25th july 2018*/
            '/*Added By Yasmin on 27th july 2018*/
            strHTML.Append(" <div class='form-group' style='border: none:'>")
            strHTML.Append(" <div class='right'>")
            If m_objAccess.Add = True Or m_objAccess.Edit = True Then
                strHTML.Append(" <button type='button' style='margin-right: 2px;' onclick='SaveBg()' class='btn btn-default save'>Save</button>")
                'strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveAddCustomerdetails(""SaveAddnew"")' title='Save and Add'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveAddSaveBg(""AddNew"")'  style='margin-left: 3px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: inline-block; padding-left: 5px;color:#fff;'></i></button>")
            End If
            strHTML.Append("<button type='button' id='HistoryBG' class='btn btn-default save clsbuttonLinks' onclick='ShowHistory_OnClick()' style=' display:none; margin-left: 5px; background-color: #343660; color: #ffffff'>Show History</button>")
            strHTML.Append(" <button type='button' onclick='Cancel()' class='btn btn-default save' style='margin-right: 19px;margin-left: 2px;'>Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")




            strHTML.Append("  </form>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append(" </div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div id='divSubRequestType'>")
        Else
            'If strWhichGrid <> "ClientContact" Then

            'strHTML.Append("<div id='divSubRequestType'>")
            If strWhichGrid <> "ClientContact" Then
                strHTML.Append("<div class='clsHideHorizontalDiv' id='DivHorizontal'>")
            End If
            strHTML.Append("<div class='h-tabs'>")

            strHTML.Append("<div class='tab'>")
            GetSubTabAccessRights(2048, TagID)
            If m_objSubTabAccess.View = True Then
                strHTML.Append("<button id='btnConfigureHRM' class='tablinks4 active clsSubtags' onclick='openCity4(event, ""OrgUnit"")' id='defaultOpen4'>Organization Units</button>")
            End If
            'GetSubTabAccessRights(3373, TagID)
            'If m_objSubTabAccess.View = True Then
            '    strHTML.Append("<button id='btnProjectMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""BGMangers"")'>Business Group Managers</button>")
            'End If
            'GetSubTabAccessRights(2121, TagID)
            'If m_objSubTabAccess.View = True Then
            '    strHTML.Append("<button id='btnGroupEmail' class='tablinks4 clsSubtags' onclick='openCity4(event, ""MLevelResources"")'>Middle LevelResources</button>")
            'End If
            'GetSubTabAccessRights(3376, TagID)
            'If m_objSubTabAccess.View = True Then
            '    strHTML.Append("<button id='btnCustomerMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""CustomerMapping"")'>Customer Mapping</button>")
            'End If
            ''GetCurrentTagAccessRights(3746)
            ''If m_objCurrentTagAccess.View = True Then
            'strHTML.Append("<button id='btnRequestTypeMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""RequestTypeMapping"")'>Request Type Mapping</button>")
            ''End If
            'GetCurrentTagAccessRights(3820)
            'If m_objCurrentTagAccess.View = True Then
            '    strHTML.Append("<button id='btnWorkingHours' class='tablinks4 clsSubtags' onclick='openCity4(event, ""WorkingHours"")'>Working Hours</button>")
            'End If
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            If strWhichGrid <> "ClientContact" Then
                strHTML.Append("<div id='ConfigureHRM' class='tabcontent4' style='display: block;'>")
                strHTML.Append("<div class='type-top-bar top-bar'>")

                GetSubTabAccessRights(2048, TagID)
                strHTML.Append("<ul class='right'>")
                If m_objSubTabAccess.Add = True Then

                    strHTML.Append("<li class='clearall'><button type='button' onclick='AddExitingOU()' style='background-color:white!important;color:black!important' class='btn btn-default' title='Add Existing Organization Unit'>Add Existing<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
                    strHTML.Append("<li class='clearall'><button type='button' onclick='AddNewOU()' style='background-color:white!important;color:black!important' class='btn btn-default' title='Add New Organization Unit'>Add New<i class='fa fa-plus' aria-hidden='true' id='IconAddNew'></i></button></li>")

                End If
              
                If m_objSubTabAccess.Delete = True Then
                    strHTML.Append("<li class='clearall'>")
                    strHTML.Append("<button onclick='Delete_OU()' id='deleteou' type='button' class='btn btn-default' title='Delete Organization Unit'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
                End If
                strHTML.Append("</ul>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='table-responsive'  id='tblConfigureHRM' >")
                strHTML.Append(WriteMasterGrid("OU", BussinessID))
                strHTML.Append(" </div>")

                strHTML.Append("<div class='pannel-section' id='customerControl'>")
                strHTML.Append("<div class='col-md-12 col-sm-12'>")

                strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
                strHTML.Append("<div class='panel'>")
                'Change by Yasmin S on 13/11/18
                strHTML.Append("<div class='panel-heading' role='tab' id='panelHRMAdd'>")
                strHTML.Append("<h3 style='font-size: 13px;' id='idheader'><span style='color:white' ID='spnOU'>Add New Organization Unit </span></h3>")
                strHTML.Append("<h4 class='panel-title'>")
                strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion'href='#collapseOne11' aria-expanded='true' aria-controls='collapseOne' id='addContact'>")
                strHTML.Append("<i class='fa fa-plus' title='Expand'  style='color:white!important'></i>")
                strHTML.Append("<i class='fa fa-minus' title='Hide' style='color:white!important'></i>")
                strHTML.Append("</a>")
                strHTML.Append("</h4>")
                strHTML.Append("</div>")

                strHTML.Append("<div id='collapseOne11' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
                strHTML.Append("<div class='panel-body' id='panelHRM'>")
                strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")

                strHTML.Append("<div class='form-group' id='AddExiting' style='display:none'>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Organization Unit*</label>")
                strHTML.Append("<div class='col-sm-6'>")
                Dim sql As String = "usp_Sel_tbl_PM_Location_AddExisting ''"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboOU", sql, 291, , " class='form-control clscombo' ", True, True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='form-group' id='AddNew'>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Unit Name *</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("UnitName", "UnitName", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Unit Name ' ", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append("</div>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Unit Code *</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("UnitCode", "UnitCode", "form-control", , 20, , , , , , , , " class='form-control'  placeholder='Enter Unit Code' ", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                
                '/*Changed By Yasmin on 25th july 2018*/
                '/*Added By Yasmin on 27th july 2018*/
                strHTML.Append(" <div class='form-group' style='border: none;    margin-left: 0px!important;'>")
                GetSubTabAccessRights(2048, TagID)
                If m_objSubTabAccess.Edit = True And m_objSubTabAccess.Add = True Then
                    strHTML.Append("<div class='right'>")
                    strHTML.Append("<div  id='ExiOu' style='display:none'>")
                    strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveExiting()' >Save</button>")
                    strHTML.Append("<button type='button' class='btn btn-default save'   onclick='SaveAddExiting(""AddNew"")' style='margin-left: 3px;margin-right: 3px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                    strHTML.Append("<button type='button' id='History' class='btn btn-default save clsbuttonLinks'  onclick='ShowSubTabHistory_OnClick()' style='margin-left: 5px; background-color: #343660; display:none;color: #ffffff'>Show History</button>")
                    strHTML.Append("<button type='button' class='btn btn-default save'  onclick='CancelOU()' >Cancel</button>")
                    strHTML.Append("</div>")
                    strHTML.Append("<div  id='NewOU'>")
                    strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveNew()' >Save</button>")
                    strHTML.Append("<button type='button' class='btn btn-default save'   onclick='SaveAddNew(""AddNew"")' style='margin-left:5px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                    strHTML.Append("<button type='button' id='History1' class='btn btn-default save clsbuttonLinks'  onclick='ShowSubTabHistory_OnClick()' style='margin-left: 5px; background-color: #343660;display:none; color: #ffffff'>Show History</button>")
                    strHTML.Append("<button type='button' class='btn btn-default save'  onclick='CancelOU()' style='margin-left:5px;'>Cancel</button>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                End If

                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</form>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")
                strHTML.Append(" </div>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")




                '2ND TAB

            Else

             
            End If

            End If
            If strWhichGrid <> "ClientContact" Then
                strHTML.Append(" </div>")
            End If
        'End If




        strHTML.Append("</div>")
        strHTML.Append("</div>")




        Return strHTML.ToString
    End Function

    Private Function WriteMasterGrid(ByVal strWhichGrid As String, ByVal BussinessGroupID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteMasterGrid()	
        ' Purpose               : To Plot the Grids
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 1 Dec 2017
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
        'str_RequestTypeID = RequestTypeID
        If strWhichGrid.ToUpper = "TYPE" Then
            intNoOfDataColumn = 3
            strDivID = "DivList"
            strSQLQuery = "usp_NG2_SEL_tbl_CNF_BusinessGroups"
            arrstrActualList = {"BusinessGroup", "BusinessGroupCode", "", ""}
            arrstrUserFriendlyList = {"Business Group Name", "Business Group Code", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objMainGrid
        ElseIf strWhichGrid.ToUpper = "OU" Then 'ContactPerson & "##" & Position & "##" & EMailID & "##" & Mobile & "##" & Phone & "##" & Address & "##" & Fax
            intNoOfDataColumn = 2
            strDivID = "divOU"
            strSQLQuery = "usp_NG2_SEL_v_tbl_CNF_BusinessGroup_OUPools " & BussinessGroupID
            arrstrActualList = {"Location", "LocationCode", "", ""}
            arrstrUserFriendlyList = {"Location", "Location Code", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objOUGrid
            'ElseIf strWhichGrid.ToUpper = "CLIENTCONTACT" Then 'ClientContact
            '    intNoOfDataColumn = 6
            '    strDivID = "divCustomerContactcilent"
            '    strSQLQuery = "usp_Ng2_sel_v_tbl_PM_Client " & RequestTypeID
            '    arrstrActualList = {"ClientCode", "ClientName", "ContactPerson", "EmailID", "MobileNumber", "Phone", "", ""}
            '    arrstrUserFriendlyList = {"Abbreviated Name", "Client Name", "Contact Person", "Email ID", "  Mobile", " Phone", "Edit", "Delete"}
            '    arrstrLinkArray = {"", "", "", "", "", "", "", ""}
            '    arrCheckBoxArray = {"", "", "", "", "", "", "", ""}
            '    arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

            '    objGrid = m_objCustomerClientContactGrid

        End If

        '/*Changed By Yasmin on 25th july 2018*/

        If Flag = 0 Then
            With objGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                '.ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                '.ColNameToolTipOnEachRow = True
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
    Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteRequestTabGrid()	
        ' Purpose               : To Plot the Customer Grid & Form
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 1 Dec 2017
        ' Revisions             : None
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        strGridHTML.Append(WriteMasterGrid(strWhichGrid, RequestTypeID))
        If (strGridFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function

    Private Sub m_objMainGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMainGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True
            Dim M_BusinessGroupID As String = ""
            'If M_BusinessGroupID = Args.DataReader("BusinessGroupID") Then

            Args.StringToBeInserted = "<td align='center' Title = 'Edit Business Group'><button type='button' class='edit-bt'  checked=true id=chkBG name=chkBG onclick='Edit_BusinessGroup(this," & Args.DataReader("BusinessGroupID") & ")' value=" & Args.DataReader("BusinessGroupID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            'Else
            '    Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt1' data-toggle='tooltip' id=chkBG name=chkBG onclick='Edit_BusinessGroup(this," & Args.DataReader("BusinessGroupID") & ")' value=" & Args.DataReader("BusinessGroupID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            'End If
            ' ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If




        Dim m_strCanBUDelete As String = ""
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanBUDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Del_f_tbl_CNF_BusinessGroups " & Args.DataReader("BusinessGroupID"), True), "0")

            If m_strCanBUDelete = "0" Then
                Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Delete Business Group'><input type=checkbox id=chkAllBU name=chkAllBU  value=" & Args.DataReader("BusinessGroupID") & " onclick='select_checkbox(this)'>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td style='text-align:center;'' Title='You do not have access to delete that record'><input type=checkbox id=chkAllBU name=chkAllBU disabled value=" & Args.DataReader("BusinessGroupID") & " onclick='select_checkbox(this)'>" + "</TD>"
            End If
        End If
    End Sub

    Private Sub m_objOUGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objOUGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True
            Dim M_BusinessGroupID As String = ""
            Args.StringToBeInserted = "<td align='center' Title = 'Edit Organization Unit'><button type='button' class='edit-bt'  checked=true id=chkOU name=chkOU onclick='Edit_OU(this," & Args.DataReader("OUPoolID") & ", " & Args.DataReader("BusinessGroupID") & "," & Args.DataReader("UniqueID") & ")' value=" & Args.DataReader("OUPoolID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"

        End If

        Dim m_strCanOUDelete As String = ""
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanOUDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Del_d_tbl_CNF_BusinessGroup_OUPools " & Args.DataReader("BusinessGroupID") & " ," & Args.DataReader("OUPoolID"), True), "0")

            If m_strCanOUDelete = "0" Then
                Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Delete Organization Unit'><input type=checkbox id=chkAllOU name=chkAllOU  onclick='select_checkbox(this)' value=" & Args.DataReader("UniqueID") & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td style='text-align:center;' Title='You do not have access to delete that record'><input type=checkbox id=chkAllOU name=chkAllOU disabled value=" & Args.DataReader("UniqueID") & " onclick='select_checkbox(this)'>" + "</TD>"
            End If
        End If

    End Sub

    Private Sub m_objMainGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objMainGrid.ColumnHeaderTD_BeforePrint

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteBU()' type=checkbox id=chkAllBU1 name=chkAllBU1 title='Select All'/></th>"
        End If


    End Sub

    Private Sub m_objOUGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objOUGrid.ColumnHeaderTD_BeforePrint

        'Added by Usha Pandit on 24 JAN 2018 for alignment issue
        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True
            Dim M_BusinessGroupID As String = ""
            Args.StringToBeInserted = "<th style='text-align:center;' class = 'Edit-All-btn' id = 'editAllHeader' onclick='changePaginationAlign()'>Edit</th>"

        End If
        'End of Added by Usha Pandit on 24 JAN 2018 for alignment issue

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            'Commented and Added by Usha Pandit on 24 JAN 2018 for alignment issue
            'Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteOU()' type=checkbox id=chkAllOU1 name=chkAllOU1 title='Select All'/></th>"
            Args.StringToBeInserted = "<th style='text-align:center;' class = 'Delete-All-btn' id = 'deleteAllHeader' onclick='changePaginationAlign()'><input onclick='DeleteOU()' type=checkbox id=chkAllOU1 name=chkAllOU1 title='Select All'/></th>"
            'End of Added by Usha Pandit on 24 JAN 2018 for alignment issue
        End If


    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteOU(ByVal SelectedOU As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteOU
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete DeleteOU
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   8 Jan 2018
        '=====================================================================
        Try
            Dim strSQL As String = ""

            Dim index As Integer = 0
            Dim Flag As Integer = 0
            Dim Restult As String = ""
            Dim intChkCount As Integer = 0
            Dim strCheckBoxValues As String = ""
            Dim arrValue() As String

            arrValue = SelectedOU.Split(CType(",", Char))
            For intChkCount = 0 To arrValue.Length - 1
                Try

                    strSQL = "exec usp_NG2_Del_tbl_PM_Location_OUPools  " & arrValue(intChkCount) & ""

                    'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
                    Flag = 1


                Catch ex As Exception

                End Try
            Next
            Return Restult
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteBG(ByVal SelectedBG As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteBG
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete BG
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   8 Jan 2018
        '=====================================================================
        Try
            Dim strSQL As String = ""

            Dim index As Integer = 0
            Dim Flag As Integer = 0
            Dim Restult As String = ""
            Dim intChkCount As Integer = 0
            Dim strCheckBoxValues As String = ""
            Dim arrValue() As String

            'Try

            '    strSQL = "exec usp_NG2_Del_tbl_CNF_BusinessGroups  " & SelectedBG & ""

            '    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            '    Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            '    Flag = 1


            'Catch ex As Exception

            'End Try


            arrValue = SelectedBG.Split(CType(",", Char))
            For intChkCount = 0 To arrValue.Length - 1
                Try
                    strSQL = "exec usp_NG2_Del_tbl_CNF_BusinessGroups  " & arrValue(intChkCount) & ""
                    'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
                    Flag = 1


                Catch ex As Exception

                End Try
            Next

            Return Restult

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckBGName(ByVal Flag As String, ByVal BussinessName As String, ByVal BGID As String, ByVal OUID As String, ByVal FlagSql As String, ByVal GlobalUniquid As String)
        '==================================================================================
        ' Procedure Name	:	CheckBGName
        ' Purpose			:	To check is duplicate BG Name & Code
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Dipali V
        ' Created			:	13-Dec-2017
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            If GlobalUniquid = "" Then
                GlobalUniquid = "Null"
            End If
            If Flag = "BG" Then
                strSQL = "usp_NG2_Sel_All_BGExistOrNot '" & BussinessName & "'," & BGID & "," & FlagSql & ""
            Else

                strSQL = "usp_NG2_Sel_All_OUExistOrNot1 '" & BussinessName & "'," & OUID & "," & BGID & ",'" & FlagSql & "'," & GlobalUniquid & ""
            End If
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetBGDetails(ByVal BGID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetBGDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Data of Customer
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	dipali Vekhande
        ' Created				:  6rd-Dec-2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim BusinessGroup As String = ""
            Dim BusinessGroupID As String = ""
            Dim BusinessGroupCode As String = ""
            Dim ManagerID As String = ""
            Dim Active As String = ""
            Dim ModifiedBy As String = ""
            Dim strSQL As String = ""

            strSQL = "usp_NG2_SEL_tbl_CNF_BusinessGroupsEdit " & BGID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                BusinessGroup = CommonFunctions.Data.CheckIsDBNull(drTabData("BusinessGroup"), "")
                BusinessGroupID = CommonFunctions.Data.CheckIsDBNull(drTabData("BusinessGroupID"), "")
                BusinessGroupCode = CommonFunctions.Data.CheckIsDBNull(drTabData("BusinessGroupCode"), "")
                ManagerID = CommonFunctions.Data.CheckIsDBNull(drTabData("ManagerID"), "")
                Active = CommonFunctions.Data.CheckIsDBNull(drTabData("Active"), "")
                ModifiedBy = CommonFunctions.Data.CheckIsDBNull(drTabData("Active"), "")

            End If
            strResult = BusinessGroup & "##" & BusinessGroupID & "##" & BusinessGroupCode & "##" & ManagerID & "##" & Active & "##" & ModifiedBy


            Return strResult

        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SaveBGDetails(ByVal BussinessName As String, ByVal BussinessGroupCode As String, ByVal BGID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveBGDetails
        ' Description           : To  Save BG Details
        ' Created Date           : 9th Jan 2018
        '=====================================================================
        Try
            Dim m_intUniqueID As Integer = 0
            Dim strSQL As String
            Dim m_BGId As String

            If BussinessName = "" Then
                BussinessName = "Null"
            End If

            If BussinessGroupCode = "" Then
                BussinessGroupCode = "Null"
            End If

            Try

                'strSQL = "exec usp_NG2_Ins_upd_tbl_CNF_BusinessGroups  '" & BussinessGroupCode & "','" & BussinessName & "'," & BGID & ""
                strSQL = "exec usp_NG2_Ins_upd_tbl_CNF_BusinessGroups  '" & BussinessGroupCode & "','" & BussinessName & "'," & BGID & ",'" & CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) & "'"
                m_BGId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))

            Catch ex As Exception

            End Try


            Return m_BGId
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function


    <System.Web.Services.WebMethod> _
    Public Shared Function SaveOUDetails(ByVal OrgnztionName As String, ByVal GlobalOUID As String, ByVal GlobalBGID As String, ByVal UniqueID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveOUDetails
        ' Description           : To  Save OU Details
        ' Created Date           : 9th Jan 2018
        '=====================================================================

        Dim m_intUniqueID As Integer = 0
        Dim strSQL As String
        Dim m_BGId As String

        If OrgnztionName = "" Then
            OrgnztionName = "Null"
        End If

        If UniqueID = "" Then
            UniqueID = "0"
        End If

        If GlobalOUID = "" Then
            GlobalOUID = "0"
        End If


        Try

            strSQL = "exec usp_NG2_Ins_upd_tbl_CNF_BusinessGroup_OUPools " & OrgnztionName & "," & GlobalBGID & "," & GlobalOUID & "," & UniqueID & ""
            m_BGId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Return m_BGId

        Catch ex As Exception
            Return "Bad Request found"

        End Try



    End Function



    <System.Web.Services.WebMethod> _
    Public Shared Function SaveNewOUDetails(ByVal UnitCode As String, ByVal UnitName As String, ByVal GlobalBGID As String, ByVal GlobalUniquid As String) As String
        '=====================================================================
        ' Procedure Name        : SaveNewOUDetails
        ' Description           : To  Save New OU Details
        ' Created Date           : 9th Jan 2018
        '=====================================================================
        Dim m_intUniqueID As Integer = 0
        Dim strSQL As String
        Dim m_BGId As String = "0"

        If UnitName = "" Then
            UnitName = "Null"
        End If
        If UnitCode = "" Then
            UnitCode = "Null"
        End If

        If GlobalUniquid = "" Then
            GlobalUniquid = "Null"
        End If

        Try

            strSQL = "exec usp_NG2_Ins_tbl_PM_Location_OrganizationStructure " & GlobalBGID & ",'" & UnitName & "','" & HttpContext.Current.Session("strUserName") & "','" & UnitCode & "'," & GlobalUniquid & ""
            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            m_BGId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            'm_BGId = "1"
            Return m_BGId
        Catch ex As Exception
            Return "Bad Request found"

        End Try



    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetOUDetails(ByVal BGID As String, ByVal OUID As String) As String
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
        ' Created				: 9th Jan 2018
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim Location As String = ""
            Dim LocationCode As String = ""
            Dim BusinessGroupCode As String = ""
            Dim OUPoolID As String = ""
            Dim NoOfResources As String = ""
            Dim UniqueID As String = ""
            Dim strSQL As String = ""

            strSQL = "usp_NG2_SEL_v_tbl_CNF_BusinessGroup_OUPoolsEdit " & BGID & ", " & OUID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                Location = CommonFunctions.Data.CheckIsDBNull(drTabData("Location"), "")
                LocationCode = CommonFunctions.Data.CheckIsDBNull(drTabData("LocationCode"), "")
                OUPoolID = CommonFunctions.Data.CheckIsDBNull(drTabData("OUPoolID"), "")
                NoOfResources = CommonFunctions.Data.CheckIsDBNull(drTabData("NoOfResources"), "")
                UniqueID = CommonFunctions.Data.CheckIsDBNull(drTabData("UniqueID"), "")


            End If
            strResult = Location & "##" & LocationCode & "##" & OUPoolID & "##" & NoOfResources & "##" & UniqueID


            Return strResult

        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function PlotSubtab(ByVal BGID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : PlotSubtab
        ' Purpose               : To SubTab
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :9th Jan 2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim OBJBusinessGroup As New BusinessGroup()

            strGridHTML.Append(OBJBusinessGroup.BussinessTabDetails(Flag, "PlotSubRequestType", BGID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid(ByVal GridParameter As Object, ByVal GlobalBGID As String, ByVal Role As String, ByVal Status As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid
        ' Created Date           : 7th Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objBusinessGroup As New BusinessGroup()

            strGridHTML.Append(objBusinessGroup.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", GlobalBGID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function



    <System.Web.Services.WebMethod()>
    Public Shared Function ShowMailHistoryDetails(ByVal UniqueID As Integer, ByVal Flag As String)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryDetails                              '
        ' Purpose				:   Call ShowMailHistoryGrid function                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :  Dipali V                                   '
        '*******************************************************************************'
        Try
            Dim BusinessGroup As New BusinessGroup
            Dim StrEditUniqueID As String = ""
            StrEditUniqueID = UniqueID
            Dim strHTML As New StringBuilder("")
            Dim str As String = BusinessGroup.ShowMailHistoryGrid(UniqueID, Flag, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    Public Function ShowMailHistoryGrid(ByVal UniqueID As Integer, ByVal Flag As String, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryGrid                                 '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   UniqueID                                            '
        ' Returns               :   grid                                                '
        ' Author                :   Dipali v                                  '
        '*******************************************************************************'
        Dim strHTML As New StringBuilder("")
        If (Flag = "Main") Then
            If (storedprocedure = Nothing) Then
                txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 1265 & "','" & UniqueID & "'")
            Else
                txtSQLQuery.Append(storedprocedure)
            End If
            strSQLQuery = txtSQLQuery.ToString
        Else
            If (storedprocedure = Nothing) Then
                txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 395 & "','" & UniqueID & "'")
            Else
                txtSQLQuery.Append(storedprocedure)
            End If
            strSQLQuery = txtSQLQuery.ToString
        End If
        'If (storedprocedure = Nothing) Then
        '    txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 1265 & "','" & UniqueID & "'")
        'Else
        '    txtSQLQuery.Append(storedprocedure)
        'End If
        '/*Changed By Yasmin on 25th july 2018*/


        arrColumnHeadingList.Add("Modified Date")
        arrColumnHeadingList.Add("Field Modified")
        arrColumnHeadingList.Add("Modified By")
        arrColumnHeadingList.Add("Value")

        arrActualColumnNames.Add("Date")
        arrActualColumnNames.Add("FieldName")
        arrActualColumnNames.Add("ModifiedBy")
        arrActualColumnNames.Add("Value")
        m_objGrid1 = New WebPages.Template.GenericGrid
        With m_objGrid1
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
    Public Shared Function FilteredHistory(ByVal newModifiedField As String, ByVal MessageID As Integer, ByVal newModifiedBy As String, ByVal Flag As String)
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
            Dim BusinessGroup As New BusinessGroup
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "Main" Then
                newModifiedField = "null"
            ElseIf newModifiedField = "SubTab" Then
                newModifiedField = "null"

            End If


            If Flag = "Main" Then
                strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 1265, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"
            Else
                strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 395, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"
            End If



            Dim str As String = BusinessGroup.ShowMailHistoryGrid(MessageID, Flag, strSQL)

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
        ' Author                : Dipali V
        ' Created               : 
        ' Revisions             :
        '===============================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
End Class