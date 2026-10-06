Public Class UploadExcel
    Inherits WebPages.Template.WhizTemplate
    Protected strIsPrductOwner As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
    End Sub

    Public Function ExcelUploadNew(Flag, From, flag2)
        '=====================================================================
        ' Procedure  Name		:	Excel Upload
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Ankush Toraskar
        ' Created				:   22/05/2018
        '=====================================================================

        Dim strHTML As New StringBuilder()
        'strHTML.Append("<a href='#lengendsExcel' id='atag' style='float:left !important;'>Step 1</a>")

        If Flag = "Upload" Then
            If From = "" Then
                'Added By Ankush T on 27 may 2018 for steps.

                strHTML.Append("<div class='btn-group btn-breadcrumb'style='width:100% !important;'>")
                strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep1' data-bs-placement='bottom' title='Excel Upload'>Step 1</a>") 'disabled
                strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep2' data-bs-placement='bottom' title='Excel Upload mapping' style='cursor:no-drop !important;'>Step 2</a>")
                strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep3' data-bs-placement='bottom' title='Upload'  style='cursor:no-drop !important;'>Step 3</a>")

                strHTML.Append("</div>")


                strHTML.Append("<div class='demo-droppable' style='margin-top: 40px;' ><p >Drag files here or click to upload</p></div>")
                strHTML.Append("<div style='float: right; margin-top: 3%; padding-left: 5px;'><button type='button' class='btn btn-primary Theam clsCategory' id='btnNext' style='margin-right:7px;'  title='Next'  onclick='Next_onclick()' >Next</button></div>")
                strHTML.Append("<div style='float: right; margin-top: 3%;'><button type='button' class='btn btn-primary Theam clsCategory' id='btnBack' style='margin-right:7px;' data-bs-dismiss='modal' title='Back'>Back</button></div>")

            Else
                strHTML.Append("<div class='btn-group btn-breadcrumb'style='width:100% !important;'>")
                'strHTML.Append("<a href='#' class='btn btn-success' data-bs-dismiss='modal' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Product Backlog'><i class='fa fa-list-ol'></i></a>")
                If flag2 = "afterprocess" Then
                    strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep1' data-bs-placement='bottom'  title='Excel Upload' onclick='BackProcess_onclick()'>Step 1</a>")
                    strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep2' data-bs-placement='bottom'  title='Excel Upload mapping' onclick='BackExcel_onclick()'>Step 2</a>")
                    strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep3' data-bs-placement='bottom' title='Upload' onclick=' Process_Click()'>Step 3</a>")
                Else
                    strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep1' data-bs-placement='bottom'  title='Excel Upload' onclick='Back_onclick()'>Step 1</a>")
                    strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep2' data-bs-placement='bottom'  title='Excel Upload mapping' onclick='Next_onclick()'>Step 2</a>")
                    strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep3' data-bs-placement='bottom' title='Upload'  style='cursor:no-drop !important;'>Step 3</a>")
                End If

                strHTML.Append("</div>")
                strHTML.Append("<div class='demo-droppable' style='margin-top:40px;'><p id='Filename'></p></div>")
                strHTML.Append("<div style='float: right; margin-top: 3%; padding-left: 5px;'><button type='button' class='btn btn-primary Theam clsCategory' id='btnNext' style='margin-right:7px;'  title='Next'  onclick='Next_onclick()'>Next</button></div>")
                strHTML.Append("<div style='float: right; margin-top: 3%;'><button type='button' class='btn btn-primary Theam clsCategory' id='btnBack' style='margin-right:7px;' data-bs-dismiss='modal' title='Back'>Back</button></div>")


            End If

        Else
            strHTML.Append("<div class='btn-group btn-breadcrumb'style='width:100% !important;'>")
            'strHTML.Append("<a href='#' class='btn btn-success' data-bs-dismiss='modal' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Product Backlog'><i class='fa fa-list-ol'></i></a>")
            If flag2 = "afterprocess" Then
                strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep1' data-bs-placement='bottom'  title='Excel Upload' onclick='BackProcess_onclick()'>Step 1</a>")  'disabled
                strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astepnew2' data-bs-placement='bottom'  title='Excel Upload mapping' onclick='Next_onclick()'>Step 2</a>")
                strHTML.Append("<a href='#' class='btn btn-info clsCategory'  id='astep3' data-bs-placement='bottom' title='Upload' onclick=' Process_Click()'>Step 3</a>")
            Else
                strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep1' data-bs-placement='bottom' title='Excel Upload' onclick='Back_onclick()'>Step 1</a>")
                strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astepnew2' data-bs-placement='bottom' title='Excel Upload mapping'>Step 2</a>") 'disabled
                strHTML.Append("<a href='#' class='btn btn-info clsCategory' id='astep3' data-bs-placement='bottom' title='Upload'  style='cursor:no-drop !important;'>Step 3</a>")
            End If

            strHTML.Append("</div>")
            strHTML.Append("<div class='col-md-12' >")
            strHTML.Append("<div class='col-md-12' id='lengendsExcel'>")
            strHTML.Append("<div class='panel-body' style='border-top-color:1px solid white!important'>")
            'strHTML.Append("<a href=# id='faClear' onclick='ClearConfigurationExcel(this);' data-bs-placement='left' data-bs-toggle='tooltip' title='Clear Configuration' style='display:inline;float:right;margin-left:5px;'  ><i class='fa fa-eraser' ></i></a>")
            'strHTML.Append("<a href=# id='faSave' onclick='SaveConfigurationExcel(this);'  data-bs-placement='left' data-bs-toggle='tooltip' title='Save Configuration' style='display:inline;float:right;'  ><i class='fa fa-save' ></i></a>")
            strHTML.Append("<table class='table' id='tblFieldList' >")
            strHTML.Append("<tbody>")

            Dim arrColCaptions() As String = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"}
            Dim strFieldQuery As String = "Usp_NG2_Sel_tbl_PM_PBSExcelUpload_Fields " & Session("intProjectID")
            'Dim drReader As IDataReader
            Dim strFieldValue As String = ""
            Dim k As Integer = 1
            Dim dtTable As DataTable
            Dim strExcelFieldName As String
            Dim dr() As DataRow

            'drReader = CommonFunctions.Data.GetDataReader(strFieldQuery, True)
            dtTable = CommonFunctions.Data.GetDataTable(strFieldQuery, True)



            'While drReader.Read
            For k = 1 To 12 Step 1
                If (k = 1 Or k = 3 Or k = 5 Or k = 7 Or k = 9 Or k = 11) Then
                    strHTML.Append("<tr>")
                End If
                dr = dtTable.Select("ExcelFieldName = '" & arrColCaptions(k - 1) & "'")

                If dr.Length <> 0 Then
                    strFieldValue = CommonFunctions.Data.CheckIsDBNull(dr(0)("PBFieldName"), "")
                    strExcelFieldName = CommonFunctions.Data.CheckIsDBNull(dr(0)("ExcelFieldName"), "")
                Else
                    strFieldValue = ""
                    strExcelFieldName = arrColCaptions(k - 1)
                End If


                strHTML.Append("<td style='vertical-align:middle;white-space:nowrap;'>")
                strHTML.Append("<label id='lblField_" & k & "' > ExcelColumn-" & arrColCaptions(k - 1) & " </label>")
                strHTML.Append("</td>")
                strHTML.Append("<td style='vertical-align:middle;'>")


                If strFieldValue = "Priority" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUSFields_" & k, "Usp_NG2_Sel_tbl_PM_PBScrumFields", 180, strFieldValue, "onchange=' USFields_OnChange(" & k & ")' class='form-control clsBorderRed' ", True, True))
                    'strHTML.Append("<span id='spnUSField_" & k & "' class='clsSpanColor' >Priority should be in 'Must Have','Should Have','Could Have','Wont Have' only in excel </span>")
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUSFields_" & k, "Usp_NG2_Sel_tbl_PM_PBScrumFields", 180, strFieldValue, "onchange=' USFields_OnChange(" & k & ")' class='form-control'", True, True))
                    strHTML.Append("<span id='spnUSFields_" & k & "' class='clsSpanColor' ></span>")
                End If

                strHTML.Append("</td>")

                If (k = 2 Or k = 4 Or k = 6 Or k = 8 Or k = 10 Or k = 12) Then
                    strHTML.Append("</tr>")
                End If
            Next


            strHTML.Append("<tr>")
            strHTML.Append("<td colspan=4 >")
            strHTML.Append("<span id='spnCommonAlert' class='clsSpanColor' ></span>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")

            strHTML.Append("</tbody>")
            strHTML.Append("</table>")

            strHTML.Append("</Div>") 'End Panel Body

            strHTML.Append("<div style='float:right; margin-top: 3%; padding-left: 5px;'><button type='button' class='btn btn-primary Theam clsCategory' id='btnProcess' style='margin-right:7px;'  title='Process File To Validate'  onclick='SaveConfig(this)'>Next</button></div>")

            strHTML.Append("<div style='float:right; margin-top: 3%;'><button type='button' class='btn btn-primary Theam clsCategory' id='btnBack' style='margin-right:7px;'  title='Back'  onclick='Back_onclick()' >Back</button></div>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
End Class
