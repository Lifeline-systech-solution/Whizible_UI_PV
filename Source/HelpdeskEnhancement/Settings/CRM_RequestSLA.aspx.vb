Imports System.IO
Imports System.IO.Compression
Imports System.Xml
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Linq

Public Class CRM_RequestSLA
    '' Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objSLAGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSubTypeGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objStatusGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objPriorityGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSeverityGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objDepartmentGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSubRequestTypeGrid As New WebPages.Template.GenericGrid

    Private WithEvents objGrid As WebPages.Template.GenericGrid
    '  Private WithEvents objSLADetailsGrid As WebPages.Template.GenericGrid
    Private WithEvents objSLADetailsGrid As New WebPages.Template.GenericGrid
    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    Private m_dsGrid As DataSet
    Protected m_intNoOfRecordInGrid As Int16 = 5
    Protected Shared m_strSLAID As Integer = 0
    Protected Shared m_strSubRequestTypeID As Integer = 0
    Protected Shared m_strStatusID As Integer = 0
    Protected Shared m_strPriorityID As Integer = 0
    Protected Shared m_strSeverityID As Integer = 0

    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected Shared RequestSLATagID As Integer = 3743
    Protected m_objAccessRights As WebPages.Security.cAccessRights
    Protected objAddAccess As String
    Protected objEditAccess As String
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
    Protected m_intRoleID As String
    Protected strLoginType As String
    Protected strUserName As String
    Protected intUserID As String
    Protected Add As String
    Protected Edit As String
    Protected Delete As String
    Protected View As String
    Protected m_strIsTypeMapped As String
    Protected str_RequestTypeID As String
    Protected m_strCanDelete As String
    Protected m_SLATagID As Integer = 3743
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Protected Shared TagID As String = ""
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intLOGINID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("strUserName"), String)
        intUserID = CType(Session("intUserID"), Integer)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
    End Sub
#Region "SLA Tab Section Related Code"
    Public Function PageInit(ByVal Flag As String)
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created               : 3 May 2017
        ' Revisions             : None
        '=====================================================================


        Dim strHTML As New StringBuilder
        strHTML.Append("<div id='HelpDeskAddSLA' class='tabcontent1 h-type clsSettingstabs' >")
        strHTML.Append(DrawSLADetails("", "Load"))
        If Flag.ToUpper = "LOAD" Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If

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
        ' Author                :	Vidya Jadhav
        ' Created               :	08-DEC-2016
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal
        objAddAccess = m_objAccess.Add
        objEditAccess = m_objAccess.Edit
    End Sub
    Private Function DrawSLADetails(ByVal SLATemplateID As String, ByVal Flag As String)
        Dim strHTML As New StringBuilder("")
        ' If Flag = "Load" Then
        GetGlobalObject()
        ' objAddAccess = m_objAccess.Add
        'objEditAccess = m_objAccess.Edit
        strHTML.Append("<div id='HelpDeskScroll'  >")
        strHTML.Append("<div class='type-top-bar top-bar'>")
        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<div class='left search-bar'>    ")
        strHTML.Append(" <i class='fa fa-search faSettingSearch' aria-hidden='true'>")
        strHTML.Append("</i> ")
        strHTML.Append("<input type='text' id='SearchSLA' placeholder='Search in table'>")
        strHTML.Append("</div>")
        strHTML.Append("</li>")

        'strHTML.Append("<li class='search-bar'>")
        ''strHTML.Append("<i class='fa fa-search' aria-hidden='true'></i>")
        ''strHTML.Append("<input type='text' id='SearchSLA' placeholder='Search in table'>")
        'strHTML.Append("<div class='left search-bar'>")
        'strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        '' strHTML.Append("<input type='text' id='myInput' onkeyup='myFunction()' placeholder='Search History' title='Type in a name'>")
        'strHTML.Append("<input type='text' id='txtSearchHistory' placeholder='Search History' title='Type in a name'>")
        'strHTML.Append("</div>")
        'strHTML.Append("</li>")
        strHTML.Append("</ul>")

        'Commented and added by Usha Pandit on 04 JAN 2018
        'strHTML.Append(" <ul class='right clsLinks'>")
        strHTML.Append(" <ul class='right clsLinks' style = 'margin-top: 6px;'>")
        'End of Added by Usha Pandit on 04 JAN 2018

        If m_objAccessRights.Add = True Then
            strHTML.Append(" <li class='clearall'>")
            strHTML.Append(" <button type='button' onclick='AddHelpDeskSLA()' title='Add SLA' class='btn btn-default'>Add<i class='fas fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccessRights.Delete = True Then
            strHTML.Append(" <li class='clearall'>")
            strHTML.Append("  <button onclick='DeleteHelpDeskSLA()' type='button' class='btn btn-default' title='Delete SLA'>Delete<i class='fas fa-trash-alt' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("  </ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='tblDivHelpDeskSLA'>")
        strHTML.Append(WriteSLATabGrid("HelpDeskSLA", "Load", ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='clsSLADetails' >")

        strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne4'>")
        strHTML.Append("<h3><span>Add New SLA Template</span></h3>")
        strHTML.Append("<h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-bs-toggle='collapse' data-parent='#accordion' href='#collapseOne' aria-expanded='true' aria-controls='collapseOne'>")
        strHTML.Append("<i class='fas fa-plus'></i>")
        strHTML.Append("<i class='fas fa-minus'></i>")
        strHTML.Append("</a>")
        strHTML.Append("</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne' class='panel-collapse collapse show' role='tabpanel' aria-labelledby='headingOne4'>") 'Added by Ashwini M on 29-3-2023
        strHTML.Append("<div class='panel-body'>")
        strHTML.Append(" <form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>SLA Template Name*</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTemplateName", "txtTemplateName", "form-control", 219, 50, , , , , , , , " class='form-control' PlaceHolder='Enter SLA Template Name'  ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group' id='FormDescription'>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Description</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , 1000, , , , , , , , "PlaceHolder='Enter Description' maxlength=''", True, , , , , , , , , ))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        '/*Added by Kashish for ui change*/
        strHTML.Append("</div >")



        '''''''''''''''''''''''''''''''''''''''''''''
        ''class='bottom-bar'
        strHTML.Append("<div >")
        strHTML.Append("<div class='pannel-section' style='margin-top:10px'>")
        strHTML.Append("<div class=''>")

        strHTML.Append("<div>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne4'>")
        strHTML.Append("<h3><span>SLA Targets</span></h3>")
        'strHTML.Append("<h4 class='panel-title'>")
        'strHTML.Append("<a role='button' data-bs-toggle='collapse' data-parent='#accordion4' href='#collapseOne4' aria-expanded='true' aria-controls='collapseOne4'>")
        'strHTML.Append("<i class='fas fa-plus'></i>")
        'strHTML.Append("<i class='fas fa-minus'></i>")
        'strHTML.Append("</a>")
        'strHTML.Append("</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne' class='panel-collapse collapse show' role='tabpanel' aria-labelledby='headingOne4'>")
        strHTML.Append("<div class='panel-body' id='divSLADetails'>")
        strHTML.Append(WriteSLAtargetTabGrid(SLATemplateID, "", ""))
        '/*Added by Kashish for ui change*/

        strHTML.Append("<div class='form-group'>")
        'col-sm-offset-9 col-sm-3
        strHTML.Append(" <div class='right'>")
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save' id='save'  onclick='SaveHelpDeskSLA()'>Save</button>")
            strHTML.Append("<button type='button' class='btn btn-default save'  id='Addsave'   onclick='SaveAddHelpDeskSLA()'>Save and Add<i class='fas fa-plus' aria-hidden='true' style='display: inline-block; padding-left: 5px;color:#fff;'></i></button>")
            strHTML.Append("<button type='button' class='btn btn-default save' id='idCancel'  onclick='Cancel_HelpDeskSLA()'>Cancel</button>")
        End If
        '/*Added by Kashish for ui change*/
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        ''''''''''''''''''''''''''''''''''''''''''
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ' If Flag = "Load" Then

        ' End If

        Return strHTML.ToString
    End Function
    Public Sub GetGlobalObject()
        '=====================================================================
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
        '=========================== ==========================================

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = TagID
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        objAddAccess = m_objAccessRights.Add
        objEditAccess = m_objAccessRights.Edit
    End Sub
    Private Sub m_objSLAGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSLAGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            If m_strSLAID = Args.DataReader("SLATemplateID") Then
                ''Args.StringToBeInserted = "<td align='center' Title = 'Select Checkbox'><a  id=chkRequestTypeSelect name=chkRequestTypeSelect  checked=true onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Edit' ><button type='button' class='edit-bt'  checked=true id=chkSLATemplateSelect name=chkSLADetailSelect onclick='Edit_SLATemplate(this," & Args.DataReader("SLATemplateID") & ")' value=" & Args.DataReader("SLATemplateID") & " ><i class='far fa-edit' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt'  id=chkSLATemplateSelect name=chkSLADetailSelect onclick='Edit_SLATemplate(this," & Args.DataReader("SLATemplateID") & ")' value=" & Args.DataReader("SLATemplateID") & " ><i class='far fa-edit' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_del_SLAMaster " & Args.DataReader("SLATemplateID"), True), "0")

            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            If m_strCanDelete = "1" Then
                'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
                'Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkSLATemplateDelete name=chkSLATemplateDelete disabled value=" & Args.DataReader("SLATemplateID") & ">" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Property is in use. Can not be deleted '><input type=checkbox id=chkSLATemplateDelete name=chkSLATemplateDelete disabled value=" & Args.DataReader("SLATemplateID") & ">" + "</TD>"
                'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
            Else
                'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
                'Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkSLATemplateDelete name=chkSLATemplateDelete  onclick='select_checkbox(this)' value=" & Args.DataReader("SLATemplateID") & " >" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Delete' ><input type=checkbox id=chkSLATemplateDelete name=chkSLATemplateDelete  onclick='select_checkbox(this)' value=" & Args.DataReader("SLATemplateID") & " >" + "</TD>"
                'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
            End If
        End If

        'If Args.DataField.ToUpper = "DESCRIPTION" Then
        '    Cancel = True
        '    Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkSLATemplateDelete name=chkSLATemplateDelete disabled  value=" & Args.DataReader("SLATemplateID") & ">" + "</TD>"
        'End If


        If Args.DataField.ToUpper = "DESCRIPTION" Then
            Cancel = True
            If Args.DataReader("Description").ToString().Length > 15 Then

                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("Description"), "") = "" Then
                    Args.StringToBeInserted = "<td>Not Specified</td>"
                Else
                    Args.StringToBeInserted = "<td>" & Args.DataReader("Description").ToString().Substring(0, 15) & "....</td>"
                End If

            Else
                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("Description"), "") = "" Then
                    Args.StringToBeInserted = "<td>Not Specified</td>"
                Else
                    Args.StringToBeInserted = "<td>" & Args.DataReader("Description") & "</td>"

                End If

            End If
        End If


    End Sub


    Private Sub m_objSLAGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objSLAGrid.ColumnHeaderTD_BeforePrint

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input onclick='DeleteMultiple_SLATemplate()' title='Select All' type=checkbox id=chkAllDeleteSLA name=chkAllDeleteSLA /></th>"

        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            '  Args.StringToBeInserted = "<th><i class='fa fa-pencil-square-o' aria-hidden='true'></i></th>"
            Args.StringToBeInserted = "<th>Edit</i></th>"
        End If

    End Sub
    'Private Sub objSLADetailsGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objSLADetailsGrid.ColumnHeaderTD_BeforePrint

    '    Select Case UCase(Trim(Args.DataField & ""))
    '        Case "TYPE"
    '            Cancel = True
    '            Args.ApplyHTMLEncode = False
    '            Args.ApplySorting = False
    '            Args.TDStyle = " "
    '            Args.StringToBeInserted = "<th align='center'>" & CommonFunctions.HTMLControls.DrawComboBox("CboType", "usp_NG2_Sel_CRM_TypeCombo", , , "class='form-control' ", False, True, , False) & "</th>"
    '    End Select
    '    ''Acknowlwdge Within", "Respond Within", "Resolve Within", "Close Within", "Excalation Email"
    '    '  Select UCase(Trim(Args.ColumnName & ""))
    '    '    Case "ACKNOWLWDGE WITHIN"
    '    '        Cancel = True

    '    '        Args.ApplySorting = False
    '    '        Args.ApplyHTMLEncode = False
    '    '        Args.StringToBeInserted = "<th align='center'>Request Type<i class='fa fa-sort' aria-hidden='true'></i></th>"

    '    '    Case "RESPOND WITHIN"
    '    '        Cancel = True

    '    '        Args.ApplySorting = False
    '    '        Args.ApplyHTMLEncode = False
    '    '        Args.StringToBeInserted = "<th align='center'>Sub Request Type<i class='fa fa-sort' aria-hidden='true'></i></th>"



    '    '        If Args.ColumnName.ToUpper = "DELETE" Then
    '    '            Cancel = True

    '    '            Args.StringToBeInserted = "<th><input onclick='DeleteMultiple_RequestType()' type=checkbox id=chkAllDeleteType name=chkAllDeleteType /></th>"

    '    '        End If

    '    '        If Args.ColumnName.ToUpper = "SELECT" Then
    '    '            Cancel = True

    '    '            '  Args.StringToBeInserted = "<th><i class='fa fa-pencil-square-o' aria-hidden='true'></i></th>"
    '    '            Args.StringToBeInserted = "<th>Edit</i></th>"
    '    '        End If
    '    'End Select
    'End Sub

    'Private Sub objSLADetailsGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objSLADetailsGrid.DataRowTD_BeforePrint
    '    ''Acknowlwdge Within", "Respond Within", "Resolve Within", "Close Within", "Excalation Email"

    '    If Args.ColumnName.ToUpper = "ACKNOWLWDGE WITHIN" Then
    '        Cancel = True

    '        Args.StringToBeInserted = "<td><div class='form-group'><div class='col-sm-4'>"
    '        Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtAckNorm_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PriorityID")) & "_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SLATemplateID")) & "", "txtNorm_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PriorityID")) & "_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SLATemplateID")) & "", "form-control", , , , , , , , , , "  class='form-control' placeholder='Enter Request Type Code' ", returnHTML:=False, EnableHTMLEncode:=True)
    '        Args.StringToBeInserted += "</div></div><td>"
    '    End If

    '    If Args.ColumnName.ToUpper = "RESPOND WITHIN" Then
    '        Cancel = True

    '        Args.StringToBeInserted = "<td><div class='form-group'><div class='col-sm-4'>"
    '        Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtResNorm_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PriorityID")) & "_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SLATemplateID")) & "", "txtNorm_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PriorityID")) & "_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SLATemplateID")) & "", "form-control", , , , , , , , , , "  class='form-control' placeholder='Enter Request Type Code' ", returnHTML:=False, EnableHTMLEncode:=True)
    '        Args.StringToBeInserted += "</div></div><td>"
    '    End If

    '    If Args.ColumnName.ToUpper = "RESOLVE WITHIN" Then
    '        Cancel = True

    '        Args.StringToBeInserted = "<td><div class='form-group'><div class='col-sm-4'>"
    '        Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtNorm_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PriorityID")) & "_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SLATemplateID")) & "", "txtNorm_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PriorityID")) & "_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SLATemplateID")) & "", "form-control", , , , , , , , , , "  class='form-control' placeholder='Enter Request Type Code' ", returnHTML:=False, EnableHTMLEncode:=True)
    '        Args.StringToBeInserted += "</div></div><td>"
    '    End If

    'End Sub

    Protected Function WriteSLATabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal SLATemplateID As String) As String
        Dim strGridHTML As New StringBuilder("")

        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, SLATemplateID))


        If (strGridFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function
    Protected Function WriteSLAtargetTabGrid(ByVal SLATemplateID As String, ByVal SLAType As String, ByVal SLATypeID As String) As String
        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        str_RequestTypeID = SLATemplateID
        Dim dtSLADetails As DataTable
        Dim TypeName As String = ""
        Dim TypeNameID As String = ""
        intNoOfDataColumn = 8
        Dim drSLADetails As DataTable
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = ""
        Dim Counter As Integer = 0
        Dim SLATypeIDSelect As Integer = 0

        Dim AcknowlwdgeWithinNorm As String = ""
        Dim AcknowlwdgeWithinUnit As String = ""
        Dim ResolveWithinNorm As String = ""
        Dim ResolveWithinUnit As String = ""
        Dim ResponseWithinNorm As String = ""
        Dim ResponseWithinUnit As String = ""
        Dim CloseWithinNorm As String = ""
        Dim CloseWithinUnit As String = ""
        Dim EscalationEmail As String = ""
        Dim ConsiderWorkHrs As String = ""
        Dim ExcludeHoldPeriod As String = ""
        Dim Flag As Integer = 0
        Dim CountRows As Integer = 0
        Dim SLADetailsID As String
        Dim FieldDictionary As New System.Collections.Specialized.StringDictionary
        Dim FieldCaptionDictionary As New System.Collections.Specialized.StringDictionary
        strDivID = "DivHelpDeskSLADetails"
        If SLATemplateID = "" Then
            SLATemplateID = "NULL"
        End If

        If SLAType = "" Then
            Dim SQLQuery As String
            Dim drType As IDataReader
            SQLQuery = "EXEC usp_NG2_Sel_CRM_TypeCombo "
            drType = CommonFunction.Data.GetDataReader(SQLQuery, True)

            If drType.Read Then
                SLATypeIDSelect = drType("ID").ToString
                SLAType = drType("Type").ToString
            End If
        End If

        If SLAType = "2" Then
            SLAType = "Severity"
            SLATypeIDSelect = 2
        End If
        If SLAType = "1" Then
            SLAType = "Priority"
            SLATypeIDSelect = 1
        End If

        If SLATypeID = "" Then
            SLATypeID = ""
        End If

        strSQLQuery = "usp_NG2_Sel_CRM_PriorityOrSeveritySLA '" & SLAType & "'"

        drSLADetails = CommonFunction.Data.GetDataTable(strSQLQuery, True)


        'For i As Integer = 0 To drSLADetails.Rows.Count - 1

        '    FieldDictionary.Add(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("PriorityID")), CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("Priority")))

        'Next


        strHTML.Append("<div class='table-responsive' id='tblTypeSLADetails'>  ")
        strHTML.Append(" <table class='table'>")
        strHTML.Append("<thead class='clsTRColumnHeader'>")
        strHTML.Append(" <tr>")
        ''Acknowlwdge Within", "Respond Within", "Resolve Within", "Close Within", "Excalation Email"
        strHTML.Append("<th>" & CommonFunctions.HTMLControls.DrawComboBox("CboType", "usp_NG2_Sel_CRM_TypeCombo", , SLATypeIDSelect, "class='form-control  form-select' onchange=Type_Onchange(this)", False, True, , False) & "</th>")
        strHTML.Append("<th style='text-align:center'>Acknowledge Within</th>")
        strHTML.Append("<th style='text-align:center'>Respond Within</th>")
        strHTML.Append("<th style='text-align:center'>Resolve Within</th>")
        strHTML.Append("<th style='text-align:center'>Close Within</th>")
        strHTML.Append("<th style='text-align:center'>Escalation Email</th>")
        strHTML.Append("<th style='text-align:center'>Consider Work Hours</th>")
        strHTML.Append("<th style='text-align:center'>Exclude Hold Period</th>")
        strHTML.Append(" </tr>")
        strHTML.Append("</thead>")
        strHTML.Append("<tbody>")


        'For i As Integer = 0 To drSLADetails.Rows.Count - 1
        '    If SLAType.ToUpper = "PRIORITY" Then
        '        TypeName = CType(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("Priority"), ""), String)
        '        TypeNameID = CType(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("PriorityID"), "0"), String)
        '    ElseIf SLAType.ToUpper = "SEVERITY" Then
        '        TypeName = CType(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("Severity"), ""), String)
        '        TypeNameID = CType(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("SeverityID"), "0"), String)
        '    End If

        '    'For i As Integer = 0 To dtSLADetails.Rows.Count - 1
        '    ''Flag = 1

        '    ' strSQL = "Exec usp_NG2_tbl_NG2_CRM_SLA_Details " & SLATemplateID & ",'" & SLAType & "'"

        strSQL = "Exec usp_NG2_sel_SLADetails_Templatewise " & SLATemplateID & ",'" & SLAType & "'"

        dtSLADetails = CommonFunctions.Data.GetDataTable(strSQL, True)

        Flag = 0
        '  CountRows = 1


        ''  If dtSLADetails.Rows.Count - 1 > 0 And Flag = 0 Then
        For i As Integer = 0 To dtSLADetails.Rows.Count - 1
            ' If dtSLADetails.Rows(i)("Priority").ToString = FieldDictionary.Item(drSLADetails.Rows(i)("PriorityID").ToString) Then
            Flag = 1
            TypeName = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("Priority").ToString, "")
            TypeNameID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("PriorityID").ToString, "")
            AcknowlwdgeWithinNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("AckNorm").ToString, "")
            AcknowlwdgeWithinUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("AckUnit").ToString, "")
            ResolveWithinNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("ResNorm").ToString, "")
            ResolveWithinUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("ResUnit").ToString, "")
            ResponseWithinNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("RespNorm").ToString, "")
            ResponseWithinUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("RespUnit").ToString, "")
            CloseWithinNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("CloseNorm").ToString, "")
            CloseWithinUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("CloseUnit").ToString, "")
            EscalationEmail = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("EscalationEmail").ToString, "")
            ConsiderWorkHrs = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("ConsiderWorkHrs").ToString, "")
            ExcludeHoldPeriod = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("ExcludeHoldPeriod").ToString, "")
            ' SLADetailsID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("SLADetailsID").ToString, "")
            'End If

            'If EscalationEmail = "True" Then
            '    EscalationEmail = "checked"
            'Else
            '    EscalationEmail = ""
            'End If

            'If ConsiderWorkHrs = "True" Then
            '    ConsiderWorkHrs = "checked"
            'Else
            '    ConsiderWorkHrs = ""
            'End If

            'If ExcludeHoldPeriod = "True" Then
            '    ExcludeHoldPeriod = "checked"
            'Else
            '    ExcludeHoldPeriod = ""
            'End If
            Dim styleDisabled As String = ""
            If AcknowlwdgeWithinNorm = "" And ResolveWithinNorm = "" And ResponseWithinNorm = "" And CloseWithinNorm = "" Then
                styleDisabled = "disabled"
            End If

            If SLADetailsID = "" Then
                SLADetailsID = "0"
            End If
            Dim strTypenameSubString As String = ""
            If TypeName.Length > 20 Then
                strTypenameSubString = TypeName.Substring(0, 20) & "..."
            Else
                strTypenameSubString = TypeName
            End If
            strHTML.Append("<tr>")
            strHTML.Append("<Input type='hidden' name='hdnCountType' id='hdnCountType'   value='" & Counter & "' />")
            strHTML.Append("<Input type='hidden' name='hdnDetailsID' id='hdnDetailsID " & SLATypeIDSelect & "_" & Counter & "'   value='" & SLADetailsID & "' />")
            strHTML.Append("<td><label data-bs-toggle='tooltip' title='" & TypeName & "' style='font-weight:normal;word-break: break-all;'>" & strTypenameSubString & "</label><Input type='hidden' name='hdnTypeNameID' id='hdnTypeNameID_" & SLATypeIDSelect & "_" & Counter & "'   value='" & TypeNameID & "' /></TD>")

            strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtAkNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtAkNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , AcknowlwdgeWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_1'  placeholder='Norm' onkeyup=EnableControls(this," & SLATypeIDSelect & "," & Counter & ")", True, EnableHTMLEncode:=True) & "</div>")
            strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboAkUnit_" & SLATypeIDSelect & "_" & Counter & "" & "", "usp_NG2_Sel_CRM_UnitCombo", , AcknowlwdgeWithinUnit, "class='form-control form-select clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_1' ", False, True) & "</div></div></td>")

            strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtResNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtResNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , ResponseWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_2'  placeholder='Norm' onkeyup=EnableControls(this," & SLATypeIDSelect & "," & Counter & ")", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboResUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , ResponseWithinUnit, "class='form-control form-select clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_2' ", False, True) & "</div></div></td>")

            strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtResolveNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtResolveNorm_" & SLATypeIDSelect & "_" & Counter, "form-control clsTxtControls", , , ResolveWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_3' placeholder='Norm' onkeyup=EnableControls(this," & SLATypeIDSelect & "," & Counter & ")", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboResolveUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , ResolveWithinUnit, "class='form-control form-select clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_3' ", False, True) & "</div></div></td>")


            strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtcloseNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtcloseNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , CloseWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_4'   placeholder='Norm' onkeyup=EnableControls(this," & SLATypeIDSelect & "," & Counter & ")", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CbocloseUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , CloseWithinUnit, "class='form-control form-select clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_4'", False, True) & "</div></div></td>")

            If EscalationEmail = "True" Then
                strHTML.Append("<td style='text-align:center'> <Input type='checkbox' name='chkEsc_" & SLATypeIDSelect & "_" & Counter & "' id='chkEsc_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' value='" & EscalationEmail & "' title='Escalation Email'  checked /></TD>")
            Else
                strHTML.Append("<td style='text-align:center'> <Input type='checkbox' name='chkEsc_" & SLATypeIDSelect & "_" & Counter & "' id='chkEsc_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' value='" & EscalationEmail & "' title='Escalation Email' " & styleDisabled & "  /></TD>")
            End If
            If ConsiderWorkHrs = "True" Then
                strHTML.Append("<td style='text-align:center'> <Input type='checkbox' name='chkWrkhrs_" & SLATypeIDSelect & "_" & Counter & "' id='chkWrkhrs_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' value='" & ConsiderWorkHrs & "' title='Consider Work Hours' checked  /></TD>")
            Else
                strHTML.Append("<td style='text-align:center'> <Input type='checkbox' name='chkWrkhrs_" & SLATypeIDSelect & "_" & Counter & "' id='chkWrkhrs_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' value='" & ConsiderWorkHrs & "' title='Consider Work Hours' " & styleDisabled & "  /></TD>")
            End If
            If ExcludeHoldPeriod = "True" Then
                strHTML.Append("<td style='text-align:center'> <Input type='checkbox' name='chkEHoldP_" & SLATypeIDSelect & "_" & Counter & "' id='chkEHoldP_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' title='Exclude Hold Period'  value='" & ExcludeHoldPeriod & "' checked /></TD>")
            Else
                strHTML.Append("<td style='text-align:center'> <Input type='checkbox' name='chkEHoldP_" & SLATypeIDSelect & "_" & Counter & "' id='chkEHoldP_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' title='Exclude Hold Period' value='" & ExcludeHoldPeriod & "'  " & styleDisabled & " /></TD>")
            End If
            strHTML.Append("</tr>")
            Counter += 1
        Next


        'Next

        ' Next
        strHTML.Append("</tbody>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")


        ' ''"AcknowlwdgeWithinNorm", "RespondWithinNorm", "ResolveWithinNorm", "CloseeWithinNorm",
        'arrstrActualList = {"", "", "", "", "", "", "ExcalationEmail", "ConsiderWorkHrs", "ExcludeHoldPeriod"}
        'arrstrUserFriendlyList = {"Type", "Acknowlwdge Within", "Respond Within", "Resolve Within", "Close Within", "Excalation Email", "Consider Work Hrs", "Exclude Hold Period"}
        'arrstrLinkArray = {"", "", "", "", "", "", "", ""}
        'arrCheckBoxArray = {"", "", "", "", "", "", "", ""}
        'arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

        'With objSLADetailsGrid
        '    .ActualColumnArray = arrstrActualList
        '    .UserFriendlyColumnArray = arrstrUserFriendlyList
        '    ' .CheckBoxIDArray = arrCheckBoxArray
        '    .NoOfDataColumns = intNoOfDataColumn
        '    .RowLinkArray = arrstrLinkArray
        '    .TDStyleArray = arrWidthArray
        '    .DIVStyle = "overflow:auto"
        '    .ColNameToolTipOnEachRow = True
        '    .EmptyValueReplacement = (" ")
        '    .DIVID = strDivID
        '    .SQL = strSQLQuery
        '    .ColNameToolTipOnEachRow = True
        '    .UseSQL = True
        '    '.ClientSideSortFunctionName = "Sort_OnClickwe_For_CRM"
        '    '.SortBy = strSortBy
        '    '.SortOrder = strSortOrder
        '    ' .CurrentPage = m_intPageNumber
        '    ' .PageSize = m_intNoOfRecordInGrid
        '    .returnHTML = True
        '    .PrimaryKey = "SLADetailsID"
        '    .IgnoreHTMLEncode = arrIgnoreHTMLEncode
        '    strGridHTML.Append(.DrawGrid())
        'End With

        ''intRecordCount = m_objGridAttachment.NoOfRows

        'objSLADetailsGrid = Nothing

        Return strHTML.ToString
    End Function
    Private Function WriteHelpdeskMasterGrid(ByVal strWhichGrid As String, ByVal SLATemplateID As String) As String
        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        str_RequestTypeID = SLATemplateID
        ''  If strWhichGrid.ToUpper = "HELPDESKSLA" Then
        intNoOfDataColumn = 3
        strDivID = "DivHelpDeskSLA"
        strSQLQuery = "usp_NG2_SEL_tbl_CNF_SLAMaster"
        arrstrActualList = {"SLATemplateName", "Description", "CreatedDate", "", ""}
        arrstrUserFriendlyList = {"Template Name", "Description", "Created Date", "Select", "Delete"}
        arrstrLinkArray = {"", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}

        objGrid = m_objSLAGrid
        ''  End If

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
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
            ' .PrimaryKey = "SLADetailID"
            .PrimaryKey = "SLATemplateID"

            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With

        'intRecordCount = m_objGridAttachment.NoOfRows

        objGrid = Nothing

        Return strGridHTML.ToString
    End Function
#End Region
#Region "Jquery AJAX Methods"
    <System.Web.Services.WebMethod>
    Public Shared Function RefreshGrid(ByVal GridParameter As Object) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid0
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objRequestSLA As New CRM_RequestSLA()

            strGridHTML.Append(objRequestSLA.WriteSLATabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod>
    Public Shared Function SaveHelpDeskSLATemplate(ByVal SaveSLADetialsData As Object) As String
        '=====================================================================
        ' Procedure Name        : SaveHelpDeskSLATemplate
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save HelpDesk SLA Template
        ' Description           :   To Save HelpDesk SLA Template
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created Date           : 21-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim Sub_RquestTypeID As String = ""
            Dim objCRM_RequestSLA As New CRM_RequestSLA()
            Dim SLATemplateID As String = SaveSLADetialsData(0)("SLATemplateID")
            Dim SLATemplateName As String
            Dim SLATemplateDescription As String
            Dim strFromEmailID As String
            Dim strToMailID As String
            Dim strCCToMailID As String
            Dim strSubject, strMessage As String
            Dim objCRM_AddNewRequest As New CRM_RequestDetailsNew
            Dim strHTML As New StringBuilder
            Dim drProductCombo As IDataReader
            Dim strAcknowledgeWithinNorm As String
            Dim strAcknowledgeWithinUnit As String
            Dim strResolveWithinNorm As String
            Dim strResolveWithinUnit As String
            Dim strRespondWithinNorm As String
            Dim strRespondWithinUnit As String
            Dim strCloseeWithinNorm As String
            Dim strCloseeWithinUnit As String
            Dim ExcalationEmail As String
            Dim ConsiderWorkHrs As String
            Dim ExcludeHoldPeriod As String
            Dim Priority As String
            Dim Severity As String
            Dim TypeID As String = ""
            Dim StrSql As String = ""
            Dim StrUniqueID As String = ""
            Dim strDetailsID As String = ""
            SLATemplateName = SaveSLADetialsData(0)("TemplateName")
            SLATemplateDescription = SaveSLADetialsData(0)("Description")
            strAcknowledgeWithinNorm = SaveSLADetialsData(0)("strAcknowledgeWithinNorm")
            ' strAcknowledgeWithinNorm = SaveSLADetialsData(0)("strAcknowledgeWithinNorm")
            strAcknowledgeWithinUnit = SaveSLADetialsData(0)("strAcknowledgeWithinUnit")
            strResolveWithinNorm = SaveSLADetialsData(0)("strResolveWithinNorm")
            strResolveWithinUnit = SaveSLADetialsData(0)("strResolveWithinUnit")
            strRespondWithinNorm = SaveSLADetialsData(0)("strRespondWithinNorm")
            strRespondWithinUnit = SaveSLADetialsData(0)("strRespondWithinUnit")
            strCloseeWithinNorm = SaveSLADetialsData(0)("strCloseeWithinNorm")
            strCloseeWithinUnit = SaveSLADetialsData(0)("strCloseeWithinUnit")
            ExcalationEmail = SaveSLADetialsData(0)("ExcalationEmail")
            ConsiderWorkHrs = SaveSLADetialsData(0)("ConsiderWorkHrs")
            ExcludeHoldPeriod = SaveSLADetialsData(0)("ExcludeHoldPeriod")
            Priority = SaveSLADetialsData(0)("Priority")
            Severity = SaveSLADetialsData(0)("Severity")
            TypeID = SaveSLADetialsData(0)("Type")
            strDetailsID = SaveSLADetialsData(0)("DetailsID")




            Dim AcknowledgeWithinNorm As String() = strAcknowledgeWithinNorm.Split(",")
            Dim AcknowledgeWithinUnit As String() = strAcknowledgeWithinUnit.Split(",")
            Dim ResolveWithinNorm As String() = strResolveWithinNorm.Split(",")
            Dim ResolveWithinUnit As String() = strResolveWithinUnit.Split(",")
            Dim RespondWithinNorm As String() = strRespondWithinNorm.Split(",")
            Dim RespondWithinUnit As String() = strRespondWithinUnit.Split(",")
            Dim CloseeWithinNorm As String() = strCloseeWithinNorm.Split(",")
            Dim CloseeWithinUnit As String() = strCloseeWithinUnit.Split(",")
            Dim IsConsiderWorkHrs As String() = ConsiderWorkHrs.ToString.Split(",")
            Dim IsExcalationEmail As String() = ExcalationEmail.Split(",")
            Dim IsExcludeHoldPeriod As String() = ExcludeHoldPeriod.Split(",")
            Dim PriorityID = Priority.Split(",")
            Dim SeverityID = Severity.Split(",")
            Dim DetailsID = strDetailsID
            Dim strSuccess As String = ""

            'Added & Commented by dipali V on 25th June 2019 For Saving Issue
            StrSql = "Usp_NG2_Ins_Upd_tbl_NG2_CRM_SLA_templateMaster  '" & SLATemplateName.Replace("'", "''") & "','" & SLATemplateDescription.Replace("'", "''") & "'," & SLATemplateID & "," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'"
            'StrSql = "Usp_NG2_Ins_Upd_tbl_NG2_CRM_SLA_templateMaster  '" & SLATemplateName & "','" & SLATemplateDescription & "'," & SLATemplateID & "," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'"
            'End of Added & Commented by dipali V on 25th June 2019 For Saving Issue
            StrUniqueID = CommonFunctions.Data.GetDataScalar(StrSql, True)
            SLATemplateID = StrUniqueID
            If SLATemplateID <> "" Or SLATemplateID <> "0" Or SLATemplateID <> "NULL" Then
                If TypeID = "1" Then
                    For ires As Integer = 0 To PriorityID.Length - 1
                        strSuccess = objCRM_RequestSLA.SaveTemplateSLADetails(SLATemplateID, SLATemplateName, SLATemplateDescription, PriorityID(ires), "0", AcknowledgeWithinNorm(ires), AcknowledgeWithinUnit(ires), ResolveWithinNorm(ires), ResolveWithinUnit(ires), RespondWithinNorm(ires), RespondWithinUnit(ires), CloseeWithinNorm(ires), CloseeWithinUnit(ires), IsExcalationEmail(ires), IsConsiderWorkHrs(ires), IsExcludeHoldPeriod(ires), TypeID)
                    Next
                ElseIf TypeID = "2" Then
                    For ires As Integer = 0 To SeverityID.Length - 1
                        strSuccess = objCRM_RequestSLA.SaveTemplateSLADetails(SLATemplateID, SLATemplateName, SLATemplateDescription, "0", SeverityID(ires), AcknowledgeWithinNorm(ires), AcknowledgeWithinUnit(ires), ResolveWithinNorm(ires), ResolveWithinUnit(ires), RespondWithinNorm(ires), RespondWithinUnit(ires), CloseeWithinNorm(ires), CloseeWithinUnit(ires), IsExcalationEmail(ires), IsConsiderWorkHrs(ires), IsExcludeHoldPeriod(ires), TypeID)
                    Next
                End If

            End If




            'Dim strSQL As String = "exec Usp_NG2_Ins_Upd_tbl_NG2_CRM_SLA_templateMaster  '" & TemplateName & "', '" & Description & "'," & HelpDeskSLAID & "," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'"
            'Sub_RquestTypeID = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return SLATemplateID.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    Public Function SaveTemplateSLADetails(ByVal SLATemplateID As String, ByVal SLATemplateName As String, ByVal Description As String, ByVal PriorityID As String, ByVal SeverityID As String, ByVal AcknowlwdgeWithinNorm As String, ByVal AcknowlwdgeWithinUNIT As String, ByVal RespondWithinNorm As String, ByVal RespondWithinUNIT As String, ByVal ResolveWithinNorm As String, ByVal ResolveWithinUNIT As String, ByVal CloseeWithinNorm As String, ByVal CloseWithinUNIT As String, ByVal ExcalationEmail As String, ByVal ConsiderWorkHrs As String, ByVal ExcludeHoldPeriod As String, ByVal TypeID As String) As String
        Dim StrSql As String = ""
        Dim StrSLASql As String = ""
        Dim StrUniqueID As String = ""
        Dim StrSLAType As String = ""
        If PriorityID = "" Then
            PriorityID = "NULL"
        End If

        If SeverityID = "" Then
            SeverityID = "NULL"
        End If
        If SLATemplateID = "" Then
            SLATemplateID = "0"
        End If

        'If AcknowlwdgeWithinNorm = "" Then
        '    AcknowlwdgeWithinNorm = "NULL"
        'End If
        'If ResolveWithinNorm = "" Then
        '    ResolveWithinNorm = "NULL"
        'End If
        'If RespondWithinNorm = "" Then
        '    RespondWithinNorm = "NULL"
        'End If
        'If CloseeWithinNorm = "" Then
        '    CloseeWithinNorm = "NULL"
        'End If
        'If DetailsID = "" Then
        '    DetailsID = "0"
        'End If
        If SLATemplateID <> "" Or SLATemplateID <> "0" Then
            'StrSql = "Usp_NG2_Ins_Upd_tbl_NG2_CRM_SLA_Details  '" & SLATemplateName & "','" & Description & "'," & PriorityID & "," & SeverityID & "," & AcknowlwdgeWithinNorm & ",'" & AcknowlwdgeWithinUNIT & "'," & RespondWithinNorm & ",'" & RespondWithinUNIT & "'," & ResolveWithinNorm & ",'" & ResolveWithinUNIT & "'," & CloseeWithinNorm & ",'" & CloseWithinUNIT & "'," & ExcalationEmail & ",'" & ConsiderWorkHrs & "'," & ExcludeHoldPeriod & "," & SLATemplateID & "," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'"
            'CommonFunctions.Data.GetDataScalar(StrSql, True)

            If TypeID = "1" Then
                StrSLAType = "Priority"
            End If
            If TypeID = "2" Then
                StrSLAType = "Severity"
            End If

            If AcknowlwdgeWithinNorm <> "0" Or ResolveWithinNorm <> "0" Or RespondWithinNorm <> "0" Or CloseeWithinNorm <> "0" Then

                StrSLASql = "usp_NG2_INS_UPD_tbl_CRM_SLATemplatesDetails  " & SLATemplateID & ",'" & StrSLAType & "'," & PriorityID & "," & SeverityID & "," & AcknowlwdgeWithinNorm & ",'" & AcknowlwdgeWithinUNIT & "'," & RespondWithinNorm & ",'" & RespondWithinUNIT & "'," & ResolveWithinNorm & ",'" & ResolveWithinUNIT & "'," & CloseeWithinNorm & ",'" & CloseWithinUNIT & "'," & ExcalationEmail & ",'" & ConsiderWorkHrs & "'," & ExcludeHoldPeriod & ",'" & HttpContext.Current.Session("strUserName") & "'"
                CommonFunctions.Data.GetDataScalar(StrSLASql, True)

            End If
        End If

        Return SLATemplateID
    End Function




    <System.Web.Services.WebMethod()>
    Public Shared Function EditSLADetails(ByVal SLATemplateID As String) As String
        '=====================================================================
        ' Procedure  Name		:	EditSLADetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Data of Request Status Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:  7-Nov-2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim strUniqueID As String = ""
            Dim TemplateName As String = ""
            Dim TemplateDescription As String = ""
            Dim OrderNumber As String = ""

            Dim strSQL As String = ""
            strSQL = "Usp_NG2_Sel_tbl_NG2_CRM_SLA_Details " & SLATemplateID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                TemplateName = CommonFunctions.Data.CheckIsDBNull(drTabData("SLATemplateName"), "")
                TemplateDescription = CommonFunctions.Data.CheckIsDBNull(drTabData("Description"), "")
            End If



            Dim strGridHTML As New StringBuilder("")
            Dim objSLADetails As New CRM_RequestSLA()

            'GetGlobalObject()
            strGridHTML.Append(objSLADetails.WriteSLAtargetTabGrid(SLATemplateID, "", ""))
            'Added by dipali V on 25th jun 2019 for Button display issue in edit mode
            strGridHTML.Append("<div class='form-group'>")


            strGridHTML.Append(" <div class='right'>")
            'If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strGridHTML.Append("<button type='button' class='btn btn-default save'   onclick='SaveHelpDeskSLA()'>Save</button>")
            strGridHTML.Append("<button type='button' class='btn btn-default save'   onclick='SaveAddHelpDeskSLA()'>Save and Add<i class='fas fa-plus' aria-hidden='true' style='display: inline-block; padding-left: 5px;color:#fff;'></i></button>")
            strGridHTML.Append("<button type='button' class='btn btn-default save' id='idCancel'  onclick='Cancel_HelpDeskSLA()'>Cancel</button>")
            'End If
            '/*Added by Kashish for ui change*/
            'End of Added by dipali V on 25th jun 2019 for Button display issue in edit mode
            strGridHTML.Append("</div>")
            strResult = strGridHTML.ToString & "##" & TemplateName & "##" & TemplateDescription
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
       

    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshSLADetailsGrid(ByVal SLATemplateID As String, ByVal SLAType As String, ByVal SLATypeID As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid0
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSLADetails As New CRM_RequestSLA()

            strGridHTML.Append(objSLADetails.WriteSLAtargetTabGrid(SLATemplateID, SLAType, SLATypeID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteSLATemplate(ByVal SLATemplateID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteSLADetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete SLA Template
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   8 Nov 2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0
        arrDelete = SLATemplateID.Split(",")
        Try
            strSQL = "exec usp_NG2_del_SLAMaster  '" & SLATemplateID & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateTemplateName(ByVal TemplateName As String, ByVal TemplateID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateTemplateName
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Template Name
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   15 Dec 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String

            strSQL = "Usp_NG2_CheckDuplicate_TemplateName '" & TemplateName & "'," & TemplateID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
#End Region
End Class