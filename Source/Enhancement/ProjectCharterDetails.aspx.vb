Imports System.Text
Imports Whizible
Public Class ProjectCharterDetails
    Inherits WebPages.Template.WhizTemplate
    Private sbHTML As New System.Text.StringBuilder
    Private Keep_stisfiedDs As DataSet
    Private Keep_informedDs As DataSet
    Private Managed_closelyDs As DataSet
    Private MoniterDs As DataSet

    Protected m_strTaskValidationMessage = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub

    Public Sub PageInit()
        DrawTable()
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SUBMIT" Then
            InsDataProjectCharter()
        End If
    End Sub
    Public Sub DrawTable()
        '=====================================================================
        ' Procedure Name        : DrawTable
        ' Purpose               : Drawing table for Stackeholder Detail
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Sanyogeeta
        ' Created               : April 28, 2016
        ' Revisions             :
        '=====================================================================
        '<tbody><tr class="clsTRMenu"><td></td><td align="Right"><ul class="responsive_clsTRMenu" style="display: block; margin-top: 0%;"><li style="float: left;"><a class="Menu" style="" onmouseover="this.style.backgroundColor='#FFD695'" onmouseout="this.style.backgroundColor=''" onclick="Javascript:Save_OnClick()" title="Save">Save</a></li><li style="float: left;"><a class="Menu" style="" onmouseover="this.style.backgroundColor='#FFD695'" onmouseout="this.style.backgroundColor=''" onclick="Javascript:Submit_OnClick()" title="Save and Fill Timesheet">Save and Fill Timesheet</a></li><li style="float: left;"><a class="Menu" style="" onmouseover="this.style.backgroundColor='#FFD695'" onmouseout="this.style.backgroundColor=''" onclick="Javascript:OpenHelpPage('QuickTasks')" title="Help">?</a></li></ul></td><div style="display: none;" class="menu_arrow_img"><img src="../General/responsive/images/downarrow.png" title="Expand"></div><ul class="additional_clsTRMenu" style="display: none; position: absolute; z-index: 999;"></ul></tr></tbody>
        'CommonFunction.General.WriteHTML("</BR></BR>")
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Project Stackeho'lder", , , True))
        ' sbHTML.Append("<DIV ID=PageDiv style='overflow:auto;width:100%; padding-top:30px; margin-left:10px'>") '390
        'start 1st Table
        sbHTML.Append("<TABLE name='PCStackhTab' id='PCStackhTab'  CellSpacing=0 cellpadding=0 Class=clsTable style='Width=100%'  >") 'Width='99.9%'
        sbHTML.Append("<TR><TD colspan='2'>&nbsp</TD></TR>")
        sbHTML.Append("<TR><TD colspan='2'>&nbsp</TD></TR>")
        sbHTML.Append("<TR><TD align='left' style='padding-left:10px'><B>Project Stackeholder</B></TD><TD align='right'><input type='button' value='Save' style='height :30px;width:70px; width: 100px; border: medium solid; border-style :medium solid; border-color:black;margin-right: 25px;font-weight: bold; !important' onclick='Javascript:Save_OnClick()'/></TD></TR>")
        'Call InsDataProjectCharter()
        sbHTML.Append("<TR><TD colspan='2'>&nbsp</TD></TR>")
        sbHTML.Append("<TR><TD colspan='2'>&nbsp</TD></TR>")
        'sbHTML.Append("<TR><TD colspan='2'>&nbsp</TD></TR>")
        sbHTML.Append("<TR><TD style='width:70%'>") '(<TD align=left >")' class='clsTRPageCaption1' 
        '1st table 1st TD and TR
        'start Second Table
        sbHTML.Append("<TABLE style='width:99%' id='tblTxtCmd' class=clsGridTable >") 'width=99.9%
      
        sbHTML.Append("<TR><TD>")
        'sbHTML.Append("<div ID=divTblGrid style='overflow:auto;'>")
        'sbHTML.Append("<Table name='QTasks' id='QTasks' class='clsGridTable' width=99.9% cellspacing=1 cellpadding=0><THead class='clsTRColumnHeader'>" + vbCrLf)
        sbHTML.Append("<THead class='clsTRColumnHeader'>" + vbCrLf)
        sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap > </TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap >Name</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap >Email Id</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap >Power Intensity</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap >Interest Intensity</TH>")
        'sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap >  </TH>")
        sbHTML.Append("</THead>")
        sbHTML.Append("</TD></TR></TABLE>")
        'second Table End
        sbHTML.Append("</TD>")
        '1st table 1st TD End 2nd Start
        sbHTML.Append("<TD style:'width:30%;' class=clsTable1 >")
        '1st Table Second TD Start
        'table For Div start
        'new div For graph       
        sbHTML.Append("<div id='Divborder' style='border:solid;border-color:black; padding-left:10px;padding-right:10px;padding-top :10px;padding-bottom:10px;'>")
        sbHTML.Append("<Table id='DivDisgn'>")
        'sbHTML.Append("<TR><TD colspan='2' style='padding-left:20px'><label id='lblnewlb' style='color:black'>Power/Interest</label></TD><TD></TD></TR>")
        sbHTML.Append("<TR><TD colspan='2'><label id='lblnewlb' style='color:black'>Power/Interest</label>")
        sbHTML.Append("<Table align='right'><TR><TD style='width:5%; background-color:red; padding-left:3px !important;' ></TD><TD style='padding-left:3px;padding-right: 3px;' >Keep Satisfied</TD>")
        sbHTML.Append("<TD style='width: 5%;background-color:orange; padding-left:3px !important; '></TD><TD style='padding-left:3px'>Managed Closely</TD></TR><TR><TD>&nbsp</TD><TD>&nbsp</TD><TD>&nbsp</TD><TD>&nbsp</TD></TR>") '
        sbHTML.Append("<TR><TD style='width: 5%;background-color:green; padding-left:3px !important;'></TD><TD style='padding-left:3px'>Moniter</TD>")
        sbHTML.Append("<TD style='width: 5%;background-color:yellow; padding-left:3px !important;'></TD><TD style='padding-left:3px'>Keep Informed</TD></TR></Table>")
        sbHTML.Append("</TD></TR>")
        sbHTML.Append("<TR><TD > <label id='lblnewlb' style='transform: rotate(90deg);transform-origin: right top 0p; color:darkblue'>Power</label></TD>")
        sbHTML.Append("<TD><div style='width :300px; border:solid;border-color:darkblue;border-top:none;border-right:none; padding-left:15px;padding-top:10px;padding-bottom :15px;'>")
        'div for plotting lines
        'sbHTML.Append("<table style='width:100%;height:100%'>")
        ''div inner tab start
        'sbHTML.Append("<tr style='width:100%;height:30%;'><td style='width:50%;border:solid;border-color :black;background-color:red; text-align :center !important;'><B>Keep Satisfied</B></td><td style='width:50%;border:solid;border-color :black;background-color:orange; text-align :center !important;' ><B>Manage Closely</B></td></tr>")
        'sbHTML.Append("<tr style='width:100%;height:30%;'><td style='width:50%;border:solid;border-color :black;background-color:green; text-align :center !important;'><B>Moniter</B></td><td style='width:50%;border:solid;border-color :black;background-color:yellow; text-align :center !important;' ><B>Keep Inform</B></td></tr>")
        'sbHTML.Append("</table>")
        'div inner tab end
        '////////////////////////////////////////////////////////////////////////////
        Dim strNmKS, strNmMC, strNmKI, strNmM As String
        Dim CalPIKS, CalPIMC, CalPIKI, CalPIM As String
        Dim CalPI, j, cnt As Integer
        Dim Keep_S, Manage_C, Keep_Informed, Moniter As String
        Dim Keep_SPI, Manage_CPI, Keep_InformedPI, MoniterPI As String
        Dim strArrKS(), strArrKI(), strArrMC(), strArrM() As String
        Dim strKS_PI(), strKI_PI(), strMC_PI(), strM_PI() As String
        '/////////////////////////////////////Keep Satisfied///////////////////////////////////////
        Keep_stisfiedDs = CommonFunction.Data.GetDataSet("usp_For_Keep_satisfied_tbl_PM_EPC_Stackeholder_Detail", "tbl_PM_EPC_Stackeholder_Detail")
        For Each Keep_stisfiedDr As DataRow In Keep_stisfiedDs.Tables(0).Rows
            strNmKS = Keep_stisfiedDr("Name").ToString()
            CalPIKS = Keep_stisfiedDr("CalPI").ToString()
            Keep_S += "<a href='javascript:ChkVal_OnClick(" + CalPIKS + ")' style='color:black;'><b>" + strNmKS + "</b></a></br>" + "$"

        Next
        strArrKS = Keep_S.Split("$")

        '/////////////////////////////////////End Keep Satisfied///////////////////////////////////////

        ''////////////////////////////////////Managed Closely///////////////////////////////////////////
        Managed_closelyDs = CommonFunction.Data.GetDataSet("usp_For_Managed_closely_tbl_PM_EPC_Stackeholder_Detail", "tbl_PM_EPC_Stackeholder_Detail")
        For Each Managed_closelyDr As DataRow In Managed_closelyDs.Tables(0).Rows
            strNmMC = Managed_closelyDr("Name").ToString()
            CalPIMC = Managed_closelyDr("CalPI").ToString()
            Manage_C += "<a href='javascript:ChkVal_OnClick(" + CalPIMC + ")' style='color:black;'><b>" + strNmMC + "</b></a></br>" + "$"

        Next
        strArrMC = Manage_C.Split("$")

        ''////////////////////////////////////End Managed Closely///////////////////////////////////////////

        '/////////////////////////////////////Moniter//////////////////////////////////////////////////
        MoniterDs = CommonFunctions.Data.GetDataSet("usp_For_Moniter_tbl_PM_EPC_Stackeholder_Detail", "tbl_PM_EPC_Stackeholder_Detail")
        For Each MoniterDr As DataRow In MoniterDs.Tables(0).Rows
            strNmM = MoniterDr("Name").ToString()
            CalPIM = MoniterDr("CalPI").ToString()
            Moniter += "<a href='javascript:ChkVal_OnClick(" + CalPIM + ")' style='color:black;'><b>" + strNmM + "</b></a></br>" + "$"

        Next
        strArrM = Moniter.Split("$")

        '/////////////////////////////////////End Moniter//////////////////////////////////////////////

        ''/////////////////////////////////////Keep Inform////////////////////////////////////////////////////
        Keep_informedDs = CommonFunctions.Data.GetDataSet("usp_For_keep_informed_tbl_PM_EPC_Stackeholder_Detail", "tbl_PM_EPC_Stackeholder_Detail")
        For Each Keep_informedDr As DataRow In Keep_informedDs.Tables(0).Rows
            strNmKI = Keep_informedDr("Name").ToString()
            CalPIKI = Keep_informedDr("CalPI").ToString()
            Keep_Informed += "<a href='javascript:ChkVal_OnClick(" + CalPIKI + ")'style='color:black;'><b>" + strNmKI + "</b></a></br>" + "$"

        Next
        strArrKI = Keep_Informed.Split("$")




        ''///////////////////////////////////////////////////////////////////////////////////////////////////

        sbHTML.Append("<Table id='MainTab' style='width:100%;height:100%'>")
        sbHTML.Append("<TR id='mainTR1' style='width:100%;height:30%;'>")
        sbHTML.Append("<TD id='mainTD11' style='width:50%;border:solid;border-color :black;background-color:red; text-align :center !important;'>")
        sbHTML.Append("<Table id='keep_satisfied'>")

        sbHTML.Append("<TR id='tr1'style='text-align :center'><TD id='td11'>" + strArrKS(0) + "</TD><TD id=td12></TD><TD id='td13'></TD><TD id='td14'></TD><TD id='td15'></TD></TR>")
        sbHTML.Append("<TR id='tr2'style='text-align :center'><TD id='td21'></TD><TD id=td22>" + strArrKS(1) + "</TD><TD id='td23'></TD><TD id='td24'></TD><TD id='td25'></TD></TR>")
        sbHTML.Append("<TR id='tr3'style='text-align :center'><TD id='td31'></TD><TD id=td32></TD><TD id='td33'>" + strArrKS(2) + "</TD><TD id='td34'></TD><TD id='td35'></TD></TR>")
        sbHTML.Append("<TR id='tr4'style='text-align :center'><TD id='td41'></TD><TD id=td42></TD><TD id='td43'></TD><TD id='td44'>" + strArrKS(3) + "</TD><TD id='td45'></TD></TR>")
        sbHTML.Append("<TR id='tr5'style='text-align :center'><TD id='td51'></TD><TD id=td52></TD><TD id='td53'></TD><TD id='td54'></TD><TD id='td55'>" + strArrKS(4) + "</TD></TR>")

        sbHTML.Append("</Table></TD>")
        'end mainTD11 And Table keep_satisfied sp - usp_For_Keep_satisfied_tbl_PM_EPC_Stackeholder_Detail
        sbHTML.Append("<TD id='mainTD12' style='width:50%;border:solid;border-color :black;background-color:orange; text-align :center !important;' >")
        sbHTML.Append("<Table id='Managed_closely'>")
        sbHTML.Append("<TR id='tr1'style='text-align :center'><TD id='td11'>" + strArrMC(0) + "</TD><TD id=td12></TD><TD id='td13'></TD><TD id='td14'></TD><TD id='td15'></TD></TR>")
        sbHTML.Append("<TR id='tr2'style='text-align :center'><TD id='td21'></TD><TD id=td22>" + strArrMC(1) + "</TD><TD id='td23'></TD><TD id='td24'></TD><TD id='td25'></TD></TR>")
        sbHTML.Append("<TR id='tr3'style='text-align :center'><TD id='td31'></TD><TD id=td32></TD><TD id='td33'>" + strArrMC(2) + "</TD><TD id='td34'></TD><TD id='td35'></TD></TR>")
        sbHTML.Append("<TR id='tr4'style='text-align :center'><TD id='td41'></TD><TD id=td42></TD><TD id='td43'></TD><TD id='td44'>" + strArrMC(3) + "</TD><TD id='td45'></TD></TR>")
        sbHTML.Append("<TR id='tr5'style='text-align :center'><TD id='td51'></TD><TD id=td52></TD><TD id='td53'></TD><TD id='td54'></TD><TD id='td55'>" + strArrMC(4) + "</TD></TR>")

        sbHTML.Append("</Table></TD></TR>")
        'end mainTD12 And  mainTR1 And Table Managed_closely sp - usp_For_Managed_closely_tbl_PM_EPC_Stackeholder_Detail
        sbHTML.Append("<TR id='mainTR2' style='width:100%;height:30%;'>")
        sbHTML.Append("<TD id='mainTD21' style='width:50%;border:solid;border-color :black;background-color:green; text-align :center !important;'>")
        sbHTML.Append("<Table id='Moniter'>")
        sbHTML.Append("<TR id='tr1'style='text-align :center'><TD id='td11'>" + strArrM(0) + "</TD><TD id=td12></TD><TD id='td13'></TD><TD id='td14'></TD><TD id='td15'></TD></TR>")
        sbHTML.Append("<TR id='tr2'style='text-align :center'><TD id='td21'></TD><TD id=td22>" + strArrM(1) + "</TD><TD id='td23'></TD><TD id='td24'></TD><TD id='td25'></TD></TR>")
        sbHTML.Append("<TR id='tr3'style='text-align :center'><TD id='td31'></TD><TD id=td32></TD><TD id='td33'>" + strArrM(2) + "</TD><TD id='td34'></TD><TD id='td35'></TD></TR>")
        sbHTML.Append("<TR id='tr4'style='text-align :center'><TD id='td41'></TD><TD id=td42></TD><TD id='td43'></TD><TD id='td44'>" + strArrM(3) + "</TD><TD id='td45'></TD></TR>")
        sbHTML.Append("<TR id='tr5'style='text-align :center'><TD id='td51'></TD><TD id=td52></TD><TD id='td53'></TD><TD id='td54'></TD><TD id='td55'>" + strArrM(4) + "</TD></TR>")
        sbHTML.Append("</Table></TD>")

        'end mainTD21 And Table Moniter sp- usp_For_Moniter_tbl_PM_EPC_Stackeholder_Detail
        sbHTML.Append("<TD id='mainTD22' style='width:50%;border:solid;border-color :black;background-color:yellow; text-align :center !important;' >")
        sbHTML.Append("<Table id='Keep_inform'>")
        sbHTML.Append("<TR id='tr1'style='text-align :center'><TD id='td11'>" + strArrKI(0) + "</TD><TD id=td12></TD><TD id='td13'></TD><TD id='td14'></TD><TD id='td15'></TD></TR>")
        sbHTML.Append("<TR id='tr2'style='text-align :center'><TD id='td21'></TD><TD id=td22>" + strArrKI(1) + "</TD><TD id='td23'></TD><TD id='td24'></TD><TD id='td25'></TD></TR>")
        sbHTML.Append("<TR id='tr3'style='text-align :center'><TD id='td31'></TD><TD id=td32></TD><TD id='td33'>" + strArrKI(2) + "</TD><TD id='td34'></TD><TD id='td35'></TD></TR>")
        sbHTML.Append("<TR id='tr4'style='text-align :center'><TD id='td41'></TD><TD id=td42></TD><TD id='td43'></TD><TD id='td44'>" + strArrKI(3) + "</TD><TD id='td45'></TD></TR>")
        sbHTML.Append("<TR id='tr5'style='text-align :center'><TD id='td51'></TD><TD id=td52></TD><TD id='td53'></TD><TD id='td54'></TD><TD id='td55'>" + strArrKI(4) + "</TD></TR>")

        sbHTML.Append("</Table></TD></TR>")
        'end mainTD22 And  mainTR2 And Table Keep_inform sp- usp_For_keep_informed_tbl_PM_EPC_Stackeholder_Detail
        sbHTML.Append("</Table>")



        '//////////////////////////////////////////////////////////////////////////
        sbHTML.Append("</div></TD>")
        sbHTML.Append("<TR><TD></TD><TD style='padding-top: 10px; color:darkblue;text-align: center;'><B>Interest</B></TD></TR>")
        sbHTML.Append("</Table>")
        sbHTML.Append("</div>")
        'graph div end
        'sbHTML.Append("</TD></TR></Table>")
        'table For Div End
        sbHTML.Append("</TD></TR></TABLE>")

        Response.Write(sbHTML.ToString())


    End Sub
    Protected Sub InsDataProjectCharter()
        Dim PCid As Integer
        Dim Proid As Integer
        Dim rowcount As Integer
        Dim txtname As String
        Dim txtEmailId As String
        Dim CmbPowerIntensity As String
        Dim CmbInterestIntensity As String
        Dim CalPI As Integer
        rowcount = CType(HttpContext.Current.Request.QueryString("LastRowNumber"), Integer)
        Dim strSQL As String
        Dim icnt As Integer
        For icnt = 1 To rowcount
            '            exec Usp_Ins_Tbl_PM_EPC_ProjectCharter  1 ,'abc', 'abc@gmai.com', '3', '2','5' 
            PCid = 4
            txtname = Request.Form("txtName" + icnt.ToString)
            txtEmailId = Request.Form("txtEmailNm" + icnt.ToString)
            CmbPowerIntensity = Request.Form("cmbPowerIntensity" + icnt.ToString)
            CmbInterestIntensity = Request.Form("cmbInterestIntensity" + icnt.ToString)
            CalPI = CmbInterestIntensity * CmbPowerIntensity
            Proid = 3

            Try

                strSQL = "Exec Usp_Ins_Tbl_PM_EPC_ProjectCharter_Details " + Convert.ToInt32(PCid).ToString() + ",'" + txtname + "','" + txtEmailId + "'," + Convert.ToInt32(CmbInterestIntensity).ToString() + "," + Convert.ToInt32(CmbPowerIntensity).ToString() + "," + Convert.ToInt32(Proid).ToString() + "," + Convert.ToInt32(CalPI).ToString() + ""
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                Response.Write("<script type='text/javascript'>")
                Response.Write("alert('Recoard Added Successfully')")
                Response.Write("</script>")
            Catch ex As Exception
                Response.Write("<script type='text/javascript'>")
                Response.Write("alert('Please Insert Correct Information')")
                Response.Write("</script>")
            End Try
        Next
    End Sub
End Class