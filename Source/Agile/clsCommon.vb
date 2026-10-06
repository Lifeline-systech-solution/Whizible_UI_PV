
Public Class clsCommon
    Inherits WebPages.Template.WhizTemplate
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected strIsPrductOwner As String = ""

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
        ' Author                :	SwapnilA
        ' Created               :	3-JAN-2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(HttpContext.Current.Session("strUserName").ToString, 22232, HttpContext.Current.Session("intPostID"), CType(HttpContext.Current.Session("intUserID"), Integer), HttpContext.Current.Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        strIsPrductOwner = CheckIsProductOwner(CType(HttpContext.Current.Session("intUserID"), Integer))
    End Sub
    Function CheckIsProductOwner(ByVal strUserID As String)
        Dim drGetIsProductOwner As IDataReader
        Dim strHTML As New StringBuilder
        Dim StrQuery As String = ""
        Dim strIsPrductOwner As String
        StrQuery = "usp_NG2_IsProductOwner " & HttpContext.Current.Session("intProjectID") & "," & strUserID & ""
        drGetIsProductOwner = CommonFunctions.Data.GetDataReader(StrQuery, True)
        While drGetIsProductOwner.Read
            strIsPrductOwner = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Result").ToString, "")

        End While
        Return strIsPrductOwner
    End Function
    Public Function PlotHeader(ByVal strEntity As String)
        '=====================================================================
        'Procedure Name         :   PlotLeftTree()
        ' Parameters Passed		:	strEntity - Page Heading
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	Plot Header for Agile Pages
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vaijat K ( Swatah Saheb )
        ' Created				:	21/02/2018
        ' Revisions				:	
        '=====================================================================
        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row HeaderFreeze'>")
        strHTML.Append("<div class='col-md-12 fixed-top'>")
        strHTML.Append("<div class='col-md-4 col-xs-4 clsDivHeader' style=''>")
        strHTML.Append(strEntity)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-md-6' style='float: right;'>")

        If strEntity = "Product Backlog" Then
            strHTML.Append("<div class='btn-group dropdown' id='divHeaderLeftSection' style='float:right;'>")
            'strHTML.Append("<i class='fas fa-cog'></i>")
            strHTML.Append("<div  data-bs-toggle='dropdown' style='cursor:pointer;margin-top:7px;margin-left: 5px;'><i  data-bs-toggle='tooltip' title='Settings' style='font-size:16px!important' class='fas fa-cog Home' data-bs-placement='bottom'></i></div>")

            'Grid View
            strHTML.Append("<Div class='dropdown-menu' role='menu'>" + vbCrLf)

            strHTML.Append("<table id=tblHeader > <tbody>" + vbCrLf)
            strHTML.Append("<tr>")
            strHTML.Append("<td  id=tblAdvHeader>")

            strHTML.Append("<p style='float:left;margin-left:2%!important'> Quick View  Configuration </p>")
            'Added & Commented By Dipali V On 11th April 2018 For Close Link Issue
            'strHTML.Append("<i class='fa fa-close' style='font-size:14px!important;color:white!important'></i>")
            strHTML.Append("<i class='fa fa-close' style='font-size:14px!important;color:#ddd!important' data-bs-toggle='tooltip' title='Close' data-bs-placement='bottom'></i>")
            'End of Added & Commented By Dipali V On 11th April 2018 For Close Link Issue
            strHTML.Append("</td>")

            strHTML.Append("</td>")
            strHTML.Append("</tr>")
            strHTML.Append("</tbody></table>" + vbCrLf)

            strHTML.Append("<table id=tblColumnView > <tbody>" + vbCrLf)
            Dim strSQLQuery As String = ""
            Dim drCheckboxView As IDataReader
            Dim intGroupCounter As Integer = 0
            strSQLQuery = "usp_NG2_sel_AttributesToShowForUserStory " & HttpContext.Current.Session("intUserID")
            drCheckboxView = CommonFunctions.Data.GetDataReader(strSQLQuery, True)

            While drCheckboxView.Read
                If intGroupCounter.ToString = "0" Then
                    strHTML.Append("<tr>" + vbCrLf)
                End If
                strHTML.Append("<td>")
                strHTML.Append(drCheckboxView("UserFriendlyName"))
                strHTML.Append("</td>")
                strHTML.Append("<td>")
                If drCheckboxView("Checked").ToString = "1" Then
                    If drCheckboxView("FieldName") = "UserStoryID" Or drCheckboxView("FieldName") = "Description" Or drCheckboxView("FieldName") = "Priority" Or drCheckboxView("FieldName") = "UserStoryName" Or drCheckboxView("FieldName") = "InitialEstimate" Then 'Commented By Dipali V On 11th April 2018 For Default Selected Fileds With Disbaled
                        strHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkColumns", "chk" & drCheckboxView("FieldName"), "clsCheckbox", True, drCheckboxView("FieldName"), True, , True, , , , , ))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkColumns", "chk" & drCheckboxView("FieldName"), "clsCheckbox", True, drCheckboxView("FieldName"), , , True, , , , , ))
                    End If
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkColumns", "chk" & drCheckboxView("FieldName"), "clsCheckbox", False, drCheckboxView("FieldName"), , , True, , , , , ))
                End If
                strHTML.Append("</td>")
                intGroupCounter += 1
                If intGroupCounter.ToString = "3" Then
                    strHTML.Append("</tr>" + vbCrLf)
                    intGroupCounter = 0
                End If
            End While
            strHTML.Append("<tr>" + vbCrLf)
            strHTML.Append("<td colspan=6 style='text-align:right;'>")
            strHTML.Append("<button type='button' id='btnClear' class='btn btn-block btn-default' data-bs-toggle='tooltip' title='Default' data-bs-placement='top' onclick= 'Default_OnClick(""ConfigField"")'; >Default</button>&nbsp;")
            'Added By Dipali V On 13th April 2018 For Access Issue
            '
            'strIsPrductOwner = CheckIsProductOwner(CType(HttpContext.Current.Session("intUserID"), Integer))
            'If strIsPrductOwner = "1" Then
            strHTML.Append("<button type='button' id='btnApply' class='btn btn-block btn-default' data-bs-toggle='tooltip' title='Apply' data-bs-placement='top' onclick= 'ApplyView_OnClick(""ConfigField"")'; >Apply</button>&nbsp;")
            'End If
            'End of Added By Dipali V On 13th April 2018 For Access Issue

            strHTML.Append("</td>")
            strHTML.Append("</tr>")
            strHTML.Append("</tbody></table>" + vbCrLf)


            strHTML.Append("</Div>" + vbCrLf)

            strHTML.Append("</div>")

            strHTML.Append("<div class='btn-group dropdown' style='float:right;padding:8px;margin-left: 5px;' data-bs-toggle='tooltip' data-bs-placement='bottom'>")
            'strHTML.Append("<i class='fa fa-ellipsis-h' data-bs-toggle='dropdown'></i>")
            strHTML.Append("<i class='fa fa-filter' id='idfilter1' title='Filter' data-bs-placement='bottom' data-bs-toggle='dropdown' onclick='show()' style='font-size: 16px !important;color: #01579b;margin-top: -2px;'></i>")
            strHTML.Append("<i class='fa fa-filter' id='idfilter'  data-bs-toggle='dropdown' onclick='Filter_clear()'  title='Clear Filter' data-bs-placement='bottom' style='display:none;color: red;font-size: 20px;margin-top: -2px;margin-left: 10px;'><i class='fas fa-times'></i></i>")
            strHTML.Append("<ul class='dropdown-menu' role='menu' style='width:160px' id='uldropdown' >")
            strHTML.Append("<li onclick=""ShowFilter('','ListView')"">")
            strHTML.Append("List View")
            strHTML.Append("</li>")
            strHTML.Append("<li onclick=""ShowFilter('','Completed')"">")
            strHTML.Append("Completed Userstories")
            strHTML.Append("</li>")
            strHTML.Append("<li onclick=""ShowFilter('','Ongoing')"">")
            strHTML.Append("Current Userstories")
            strHTML.Append("</li>")
            strHTML.Append("<li onclick=""ShowFilter('','Active')"">")
            strHTML.Append("Active Userstories")
            strHTML.Append("</li>")
            strHTML.Append("<li onclick=""ShowFilter('','InActive')"">")
            strHTML.Append("Inactive Userstories")
            strHTML.Append("</li>")
            'strHTML.Append("<li>")
            'strHTML.Append("Sprint")
            'strHTML.Append("</li>")
            Dim SQLRelease As String = ""
            SQLRelease = "usp_NG2_Sel_Product_FilterSprintRelease " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",Release"
            Dim SQL As String = ""
            SQL = "usp_NG2_Sel_Product_FilterSprintRelease " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",Iteration"
            strHTML.Append("<li id='listSprint'>")
            strHTML.Append("<i class='fa fa-plus-circle'  onclick=ShowStatus(this,'divSprints')></i>  By Sprints")
            strHTML.Append("<div id='divSprints' class='clsFilterDiv' style='display:none;background-color:white'>")
            strHTML.Append("<div class='form-group row' style='margin-top:10px;background-color:white' id='filtergrup1'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ProductFilterSprint", SQL, , , "class='form-control' style='width:82%;margin-left: 33px;' onchange=ShowFilter('','Sprint')", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")

            strHTML.Append("<li id='listRelease'>")
            'strHTML.Append("Release")
            strHTML.Append("<i class='fa fa-plus-circle'  onclick=ShowStatus(this,'divRelease')></i> By Release ")
            strHTML.Append("<div id='divRelease' class='clsFilterDiv' style='display:none;background-color:white'>")
            strHTML.Append("<div class='form-group row' style='margin-top:10px;background-color:white' id='filtergrup11'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ProductFilterRelease", SQLRelease, , , "class='form-control' style='width:82%;margin-left: 33px;' onchange=ShowFilter('','Release')", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")
            strHTML.Append("</ul>")

            strHTML.Append("</div>")
            'Added By Dipali V On 10th April 2018 For Access Issue
            GetAccessRights()
            If strIsPrductOwner = 1 Then
                If m_objAccess.Add = True Then
                    strHTML.Append("<div class='btn-group' style='float:right;display:inline-flex;top: -2px;'>")
                    strHTML.Append("<button type='button' class='btn btn-info clsCategory' style=''>")
                    strHTML.Append("Create")
                    strHTML.Append("</button>")
                    strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle clsCategory' style='' data-bs-toggle='dropdown'>")
                    strHTML.Append("<span class='caret'></span>")
                    strHTML.Append("</button>")
                    strHTML.Append("<ul class='dropdown-menu' id='ulmodal'>")
                    strHTML.Append("<li class='dropdown-item' onclick=ShowModal('User','')>")
                    strHTML.Append("User Story")
                    strHTML.Append("</li>")
                    strHTML.Append("<li class='dropdown-item' onclick=ShowModal('Sprint','')>")
                    strHTML.Append("Sprint")
                    strHTML.Append("</li>")
                    strHTML.Append("<li class='dropdown-item' onclick=ShowModal('Release','')>")
                    strHTML.Append("Release")
                    strHTML.Append("</li>")
                    ''Added By Nikhil A on 4-April-2018
                    'Commented by Ankush on 01 June 2018
                    'strHTML.Append("<li class='dropdown-item' onclick=ShowModal('ExcelUpload','')>")
                    'strHTML.Append("Excel Upload")
                    'strHTML.Append("</li>")

                    strHTML.Append("<li class='dropdown-item' onclick=ShowModal('ExcelUploadNew','')>")
                    strHTML.Append("Excel Upload")
                    strHTML.Append("</li>")
                    'End of Commented by Ankush on 01 June 2018
                    ''End of Added By Nikhil A 4-April-2018
                    ''Added By Dipali  V 22-May-2018
                    'strHTML.Append("<li class='dropdown-item' onclick=ShowModal('ExcelUploadNew','')>")
                    'strHTML.Append("Excel Upload")
                    'strHTML.Append("</li>")
                    ''End of Added By  Dipali V 22-May-2018
                    strHTML.Append("</ul>")
                    strHTML.Append("</div>")
                Else
                    strHTML.Append("<div class='btn-group dropdown' style='float:right;cursor: no-drop;' >")
                    strHTML.Append("<button type='button' class='btn btn-info'>")
                    strHTML.Append("Create")
                    strHTML.Append("</button>")
                    strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
                    strHTML.Append("<i class='fa fa-sort-down' style='cursor: no-drop;'></i>")
                    strHTML.Append("</button>")
                    strHTML.Append("</div>")
                End If
            Else
                If m_objAccess.Add = True Then
                    strHTML.Append("<div class='btn-group dropdown' style='float:right'>")
                    strHTML.Append("<button type='button' class='btn btn-info'>")
                    strHTML.Append("Create")
                    strHTML.Append("</button>")
                    strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
                    strHTML.Append("<i class='fa fa-sort-down'></i>")
                    strHTML.Append("</button>")
                    strHTML.Append("<ul class='dropdown-menu' id='ulmodal'>")
                    strHTML.Append("<li class='dropdown-item' onclick=ShowModal('User','')>")
                    strHTML.Append("User Story")
                    strHTML.Append("</li>")
                    strHTML.Append("<li class='dropdown-item' onclick=ShowModal('ExcelUploadNew','')>")
                    strHTML.Append("Excel Upload")
                    strHTML.Append("</li>")
                    strHTML.Append("</ul>")
                    strHTML.Append("</div>")
                Else
                    strHTML.Append("<div class='btn-group dropdown' style='float:right;cursor: no-drop;' >")
                    strHTML.Append("<button type='button' class='btn btn-info'>")
                    strHTML.Append("Create")
                    strHTML.Append("</button>")
                    strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split ' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
                    strHTML.Append("<i class='fa fa-sort-down' style='cursor: no-drop;'></i>")
                    strHTML.Append("</button>")
                    strHTML.Append("</div>")
                End If
            End If

            'End of Added By Dipali V On 10th April 2018 For Access Issue



            strHTML.Append("<div class='input-group input-group-sm' style='width: 165px;right:20px !important;float:right;margin-top: -3px;'><input type='text' name='table_search' id='txtSearchPendingP' class='txtBox form-control float-end' value='' onkeyup=PerformSearchForPTI() placeholder='Search'><div class='input-group-btn' style='top: 3px;'><button type='button' id='btnFilter' class='btn btn-default' onclick=PerformSearchForPTI()><i class='fa fa-search'></i></button></div></div>")
            'Added By Dipali V On 13th April 2018 For Add Catgory Functionality
            ' strHTML.Append("<a id='add-btn' class='add-dynamic-div' title='Add Stage' data-bs-toggle='tooltip'><i class='fa fa-plus'></i></a>")
            'End of Added By Dipali V On 13th April 2018 For Add Catgory Functionality
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        Else

            strHTML.Append("<Div style='text-align:right;color:#dd4b39;' ><span > Note : Cancel user story can not drag to next stage. </span></Div>" + vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        Return strHTML.ToString()
    End Function
    Public Shared Sub GetEmailMessage_20045(ByRef strFromEmailID As String, ByRef strToEmailID As String, ByRef strCCToEmailID As String, ByRef strSubject As String, ByRef strEmailMessage As String, ByVal intSprintID As Integer)
        '=====================================================================
        ' Procedure Name		:	GetEmailMessage_20045
        ' Parameters Passed     :	strToEmailID	:- The EmailID of the person to whom the message will be returned.
        '							strSubject		:- The Subject of the Email Message.
        '							strEmailMessage	:- The body of the Email Message.
        '							intSprintID    	:- The Sprint ID
        ' Returns               :	
        ' Parameters Affected   :	strToEmailID, strSubject, strEmailMessage :- These values are returned by the subroutine by reference.
        ' Description           :	Generate the email message as defined in the System Email Messages table in the database.
        ' Purpose               :	Generate the email message as defined in the System Email Messages table in the database.
        ' Assumptions		    :	The message ID exists in the database.
        ' Dependencies          :	None.
        ' Author                :	Aniruddh Gujar
        ' Created               :	10-May-2018.
        ' Revisions             :
        '=====================================================================	
        Dim strUserName As String
        Dim intMessageID As Integer
        Dim strSQL As String
        Dim strIterationName As String
        Dim drIteration As IDataReader
        Dim strProjectName As String

        intMessageID = 20045

        strSQL = "EXEC usp_NG2_GetMailDetailsForSprint " + intSprintID.ToString
        drIteration = CommonFunction.Data.GetDataReader(strSQL, True)
        While drIteration.Read
            strProjectName = CommonFunction.General.CheckIsNothing(drIteration("ProjectName"), "")
            strIterationName = CommonFunction.General.CheckIsNothing(drIteration("IterationName"), "")
            strToEmailID = CommonFunction.General.CheckIsNothing(drIteration("ToEmailID"), "")
            strCCToEmailID = CommonFunction.General.CheckIsNothing(drIteration("CcEmailID"), "")
        End While
        strEmailMessage = funcGetEmailMessageForProject(CType(HttpContext.Current.Session("intProjectID"), Long), intMessageID, strSubject)
        ' Retrieve information about the Project.
        strEmailMessage = Replace(strEmailMessage, "<PROJECT_NAME>", strProjectName)
        strEmailMessage = Replace(strEmailMessage, "<SPRINT_NAME>", strIterationName)

        Call GetSenderInfo(strUserName, strFromEmailID)
        strEmailMessage = Replace(strEmailMessage, "<SENDER_NAME>", strUserName)

    End Sub
    Private Shared Function funcGetEmailMessageForProject(ByVal lngProjectID As Long, ByVal lngMsgID As Long, ByRef strSubject As String) As String
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim blnUseSQL As Boolean
        Dim strBody As String

        strBody = ""
        blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        strSQL = "usp_Sel_tbl_PM_EmailMessages " + lngMsgID.ToString
        If lngProjectID > 0 Then
            strSQL += "," + lngProjectID.ToString
        End If

        objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
        If objDr.Read Then
            strBody = objDr("Body").ToString + ""
            strSubject = objDr("subject").ToString + ""
        End If
        CommonFunction.Data.DisposeDataReader(objDr)

        funcGetEmailMessageForProject = strBody

    End Function
    Private Shared Sub GetSenderInfo(ByRef strUserName As String, ByRef strEmailID As String)
        Dim strLoginType As String
        Dim lngUserid As Long

        strLoginType = HttpContext.Current.Session("LoginType").ToString
        lngUserid = CType(HttpContext.Current.Session("intUserID"), Long)

        If strLoginType = "C" Then
            Call GetCustomerInfo(lngUserid, strUserName, strEmailID)
        ElseIf strLoginType = "E" Then
            Call GetEmployeeInfo(lngUserid, strUserName, strEmailID)
        End If
        If strEmailID = "" Then
            strEmailID = funcGetCompanyMailID()
        End If
    End Sub
    Private Shared Sub GetCustomerInfo(ByVal lngCustomerID As Long, ByRef strCustomerName As String, ByRef strEmailid As String)
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strLoginType As String
        Dim blnUseSQL As Boolean

        blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
        strSQL = "usp_Sel_tbl_PM_Customer " + lngCustomerID.ToString + ",NULL,'C'"
        objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
        If objDr.Read Then
            strCustomerName = objDr("CustomerID").ToString + ""
            strEmailid = objDr("Emailid").ToString + ""
        End If
        CommonFunction.Data.DisposeDataReader(objDr)

    End Sub
    Public Shared Sub GetEmployeeInfo(ByVal lngUserID As Long, ByRef strUserName As String, ByRef strEmailid As String)
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim blnUseSQL As Boolean

        blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        strSQL = "usp_tbl_Sel_EmployeeInfo " + lngUserID.ToString
        objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
        If objDr.Read Then
            strUserName = objDr("UserName").ToString + ""
            strEmailid = objDr("EmailID").ToString + ""
        End If
        CommonFunction.Data.DisposeDataReader(objDr)
    End Sub
    Public Shared Function funcGetCompanyMailID() As String
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim blnUseSQL As Boolean
        Dim strEmailID As String

        blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        strSQL = "Select * From tbl_PM_CompanyInformation"
        objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
        If objDr.Read Then
            strEmailID = objDr("Email").ToString + ""
        End If
        CommonFunction.Data.DisposeDataReader(objDr)

        funcGetCompanyMailID = strEmailID.Trim
    End Function
End Class
