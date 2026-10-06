<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectCharterDetails.aspx.vb" Inherits="PbNIT.ProjectCharterDetails" %>

<!DOCTYPE HTML>
<html>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <% CommonFunctions.General.PlotPageHeadTag("Project Charter Details")%>
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
  
   <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript""></script> -->


   <script src="../../responsive/responsive.js"></script>

<body class="clsBody" style="height:800px">
    <form id="frmProjectCharterDetails" method="post" runat="server">   
         <%PageInit()%>         

    </form>
    
    <script>

        function GetOReference(strFormId, strElementId, blnIsName) {
            var objElement;
            var objCombo;

            if (blnIsName) {
                objElement = document.getElementsByName(strElementId);
            }
            else if (!(blnIsName)) {
                objElement = document.getElementById(strElementId);
            }
            return objElement;

        }
        function GetFormReference(strFormId) {
            var objElement;

            objElement = document.getElementById(strFormId);
            return objElement;
        }
        function deleteRowSection(evt, deleteRow) {
            objtblMSSection.deleteRow(evt.parentNode.parentNode.rowIndex);
            deleteButtonHitCountMSSection = parseInt(deleteButtonHitCountMSSection) + 1;
            noOfRows = noOfRows - 1;
            totalcount = totalcount - 1;
            deleteArr.push(deleteRow);

        }
        var objTbl = GetObjectReference('', 'tblTxtCmd');
        var objQTaskCounter = GetObjectReference('', 'RowNumber');
        var objtxtNameID, objtxrEmailID;
        objtxtNameID = GetObjectReference('frmProjectCharterDetails', 'txtNameID');
        objtxrEmailID = GetObjectReference('frmProjectCharterDetails', 'txtEmailID');
        var noOfRows; var LastRowNumber; LastRowNumber = -1; var isInValid = 0;

        if (objQTaskCounter != null)
            noOfRows = parseInt(objQTaskCounter.value) - 1;
        else
            noOfRows = 0;
        NewTR1 = objTbl.insertRow(objTbl.rows.length);
        NewTR1.className = 'clsTRBlank';
        NewTD1 = NewTR1.insertCell(0);
        NewTD1.align = 'center';
        NewTD1.innerHTML = "<td width=10px ALIGN='center' colspan='6'><A href='javascript:ShowHide_SectionTR()'><Img Border=0 id=tdShowHide Src='../../Images/Home/add-128.png' style='height:17px; width:17px' title='Click here to add new record'></A></td>";
        NewTD1 = NewTR1.insertCell(1);
        NewTD1 = NewTR1.insertCell(2);
        NewTD1 = NewTR1.insertCell(3);
        NewTD1 = NewTR1.insertCell(4);
        //NewTD1 = NewTR1.insertCell(5);
        function ShowHide_SectionTR() {
            DrawNewRow();
        }
        function deleteRow(evt) {
            objTbl.deleteRow(evt.parentNode.parentNode.rowIndex);
        }

        var objform = GetFormReference('frmProjectCharterDetails');
        var objtblMSSection = GetOReference('frmProjectCharterDetails', 'tblTxtCmd');
        var totalcount = objtblMSSection.rows.length - 1;
        var  cnt = 0;
        function DrawNewRow()
        {
            noOfRows = noOfRows + 1;
            var strcombohtml;
            var NewTR, newTD;
            
            NewTR = objTbl.insertRow(objTbl.rows.length - 1);
            NewTR.className = 'clsTREven';
            NewTD = NewTR.insertCell(0);
            NewTD.align = 'left';
            NewTD.innerHTML = "<td > <IMG BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'deleteRow(this)'></td>";

            
            cnt = cnt + 1;
            NewTD.width = '1%';
            //NewTD.innerHTML = "<tr >";+
            NewTD.innerHTML = "<td ><Input type=hidden name='txtMSSectionID" + totalcount + "' id='txtMSSectionID" + totalcount + "' value=0  /> <IMG ID='imgDelete" + totalcount + "' BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'deleteRowSection(this," + totalcount + ")'>";
            NewTD.innerHTML += "<Input type=hidden name='imgDelete_" + totalcount + "' id='imgDelete_" + totalcount + "' value='" + totalcount + "'  /></td>"

            // Name
            NewTD = NewTR.insertCell(1);
            NewTD.align = 'left';
            
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtName", "txtName", , 150, 255, , , "style='width:90%;Height:30% '", , , , , , True, True, , , , 1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'                     
            strcombohtml = strcombohtml.replace(/txtName/g, "txtName" + cnt)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';


            //Email ID
            NewTD = NewTR.insertCell(2);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtEmailNm", "txtEmailNm", , 150, 255, , , "style='width:90%;Height:30% '", , , , , , True, True, , , , 1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'                     
          
            strcombohtml = strcombohtml.replace(/txtEmailNm/g, "txtEmailNm" + cnt)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Power Intensity
            NewTD = NewTR.insertCell(3);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cmbPowerIntensity", "usp_Cmd_tbl_PM_EPC_PowerIntensity_For_ProjectCharterDetail", 150, , , True, True, "style='width:90%;Height:30% '", True, , False, 1).ToString.Replace("'", "\'")%>'
           
            strcombohtml = strcombohtml.replace(/cmbPowerIntensity/g, "cmbPowerIntensity" + cnt)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Interest Intensity

            NewTD = NewTR.insertCell(4);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cmbInterestIntensity", "usp_Cmd_tbl_PM_EPC_InterestIntensity_For_ProjectCharterDetail", 150, , , True, True, "style='width:90%;Height:30% '", True, , False, 1).ToString.Replace("'", "\'")%>'
           
            strcombohtml = strcombohtml.replace(/cmbInterestIntensity/g, "cmbInterestIntensity" + cnt)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
            //very imp vertical-align: middle;

           // NewTD = NewTR.insertCell(5);
           // NewTD.align = 'left';
           // strcombohtml = "<button type='button' id='btnSubmit" + cnt + "' Name='BtnSubmit" + cnt + "' style='height :30px;width:50px; width: 100px; border: medium solid; border-style :medium solid; border-color:black;margin-right:5px;font-weight: bold; !important'>Submit</button>";

           //// strcombohtml = strcombohtml.replace(/cmbInterestIntensity/g, "cmbInterestIntensity" + cnt)
           // NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
           LastRowNumber = noOfRows;                  

            
        }
      
        function Save_OnClick()
        {
           // debugger;
            alert(LastRowNumber);
           // var objRowNumber = GetObjectReference('frmProjectCharterDetails', 'RowNumber');
            //if (objRowNumber != null) {
            for (var i = 1; i <= LastRowNumber; i++) {
                //for (i = 1; i < objRowNumber.value; i++) {

                    var ObjtxtName = GetObjectReference('frmProjectCharterDetails', 'txtName' + i);
                    if (ObjtxtName != null) {
                        if ((ObjtxtName).value == "") {
                            alert('Name must be filled out.');
                            ObjtxtName.focus();
                            isInValid = 1;
                            return;
                        }
                    }



                    var ObjtxtEmailNm = GetObjectReference('frmProjectCharterDetails', 'txtEmailNm' + i);

                    if (ObjtxtEmailNm != null) {
                        if ((ObjtxtEmailNm).value == "") {
                            alert('Email must be filled out.');
                            isInValid = 1;
                        }
                    }
                    else {
                        var x1 = document.getElementById("txtEmailNm" + i).value;
                        var atpos = x1.indexOf("@");
                        var dotpos = x1.lastIndexOf(".");
                        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x1.length) {
                            alert("Not a valid e-mail address");
                            ObjtxtEmailNm.focus();
                            isInValid = 1;
                            return;
                        }

                    }


                    var ObjPowerIntensity = GetObjectReference('frmProjectCharterDetails', 'cmbPowerIntensity' + i);
                    if (ObjPowerIntensity != null) {
                        if (trimString(ObjPowerIntensity.value) == "") {
                            alert('Please select PowerIntensity.');
                            ObjPowerIntensity.focus();
                            isInValid = 1
                            return;
                        }
                    }
                    var ObjInterestIntensity = GetObjectReference('frmProjectCharterDetails', 'cmbInterestIntensity' + i);
                    if (ObjInterestIntensity != null) {
                        if (trimString(ObjInterestIntensity.value) == "") {
                            alert('Please select Interest Intensity.');
                            ObjInterestIntensity.focus();
                            isInValid = 1
                            return;
                        }
                    }
                   // debugger;
                    isInValid = 0;
                }
            //}
            if (isInValid == 1)
            {
                return
            }
            else if (isInValid == 0) {
                //Added by Tejal D date 12/10/2016 for FOR SAVE ISSUE 

                var MenuTags = document.getElementsByTagName('A');
                for (i = 0; i < MenuTags.length; i++) {
                    if (MenuTags[i].className == "Menu") {
                        //MenuTags[i].style.display= "none";
                        MenuTags[i].parentNode.style.display = "none";
                    }
                }
                setFrameLoader();
                //End of Addtion by tejal Deshmukh date 12/10/2016  FOR SAVE ISSUE 

                objform.action = "../Enhancement/ProjectCharterDetails.aspx?LastRowNumber=" + LastRowNumber + "&Mode=SUBMIT";
                objform.submit();
            }
            
        }
        
        function ChkVal_OnClick(CalPIOut)
        {
          
            alert(LastRowNumber);
            window.open("../Enhancement/StackeholderDetails.aspx?CalPIOut=" + CalPIOut + "", "", "resizable=no,width=300,height=150,Left=400,Top=230");
        }
        function validateFormLstNm() {
            alert(LastRowNumber);
            for (var i = 1; i < 10; i++) {
                debugger;
                var chk = "txtName" + i;
                var x = document.getElementById("txtName" + i).value;
                if (x == null || x == "") {
                    alert("Name must be filled out");
                    document.getElementById('txtName').focus();
                    return false;
                }
                debugger;
                var chk1 = "txtEmailNm" + i;
                var x1 = document.getElementById("txtEmailNm" + i).value;
                var atpos = x1.indexOf("@");
                var dotpos = x1.lastIndexOf(".");               
                if (x1 == null || x1 == "")
                {
                    alert(" e-mail must be filled out");
                }
               else if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x1.length) {
                    alert("Not a valid e-mail address");
                    document.getElementById('txtEmailNm'+i).focus();
                    return false;
               }
               

                //var z = document.forms["frmProjectCharterDetails"]["cmbPowerIntensity"+ i].value;               
                //if (z == null || z == "")
                //{
                //    alert("Select Value From PowerIntensity");                   
                //    document.forms["frmProjectCharterDetails"]["cmbPowerIntensity" + i].focus();
                //    return;
                //}
                //var x3 = document.forms["frmProjectCharterDetails"]["cmbInterestIntensity" + i].value;
                //if (x3 == null || x3 == "")
                //{
                //    alert("Selcet Value From Interest Intensity");                
                //    document.forms["frmProjectCharterDetails"]["cmbInterestIntensity" + i].focus();
                //    return ;
                    
                //}             
                
            }
           
        }

       
      
            
    </script>
    <%--<script type="text/javascript" >
        $(document).ready(function () {
            function createNewRow() {
                noOfRows = noOfRows + 1;

                var strcombohtml;
                var NewTR, newTD;

                NewTR = objTbl.insertRow(objTbl.rows.length - 1);
                NewTR.className = 'clsTREven';
                NewTD = NewTR.insertCell(0);
                NewTD.align = 'left';
                NewTD.innerHTML = "<td > <IMG BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'deleteRow(this)'></td>";

                //Project       
                NewTD = NewTR.insertCell(1);
                NewTD.align = 'left';
                //strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("ProjectID", "usp_Sel_ListOfProject_QuickTask 0", 150, "", "onchange=javascript:Project_Change", True, True, , True, , , 1).ToString.Replace("'", "\'")%>'
                strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtName", "txtNameID", , , , 0, , , , , , False, , True).ToString.Replace("'", "\'")%>'
                strcombohtml = strcombohtml.replace(/txtName/g, "txtName" + noOfRows);
               // strcombohtml = strcombohtml.replace(/Project_Change/g, "Project_Change(" + noOfRows + ")");
                NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                FillProjectDropdown(noOfRows);

                            //Task Name/Description
                NewTD = NewTR.insertCell(2);
                NewTD.align = 'left';
               // strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("Description", "Description", , 300, 255, , , , , , , , , True, , , , , 1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'
                strcombohtml= '<%= CommonFunctions.HTMLControls.DrawTextBox("txtEmailNm", "txtEmailID", , , , 0, , , , , , False, , True).ToString.Replace("'", "\'")%>'
                strcombohtml = strcombohtml.replace(/txtEmailNm/g, "txtEmailNm" + noOfRows)
                NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                            //Task Type
                NewTD = NewTR.insertCell(3);
                NewTD.align = 'left';
                strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("txtPowerIntensityID", "txtPowerIntensityNm", 150, "", "onchange=txtPowerIntensityID_Change", True, True, , True, , , 1).ToString.Replace("'", "\'")%>'
                strcombohtml = strcombohtml.replace(/txtPowerIntensityID/g, "txtPowerIntensityID" + noOfRows)
                strcombohtml = strcombohtml.replace(/txtPowerIntensityID_Change/g, "txtPowerIntensityID_Change(" + noOfRows + ")");
                NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                            //Sub Task Type
                //NewTD = NewTR.insertCell(4);
               // NewTD.align = 'left';
               // strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("SubTaskTypeID", "usp_Sel_SubTasks 0,0", 100, "", , True, True, , , , , 1).ToString.Replace("'","\'") %>'
               // strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("SubTaskTypeID", "usp_Sel_SubTasks 0,0", 100, "", , True, True, , , , , 1).ToString.Replace("'","\'") %>'

               // strcombohtml = strcombohtml.replace(/SubTaskTypeID/g, "SubTaskTypeID_" + noOfRows)
                //NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                            //Priority
                //NewTD = NewTR.insertCell(5);
                //NewTD.align = 'left';
                //strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("Priority", "usp_Sel_tbl_IB_Priorities", 90, "", , True, True, ,True , , , 1).ToString.Replace("'","\'") %>'
               // strcombohtml = strcombohtml.replace(/Priority/g, "Priority_" + noOfRows)
               // NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                            //Actual Work Hrs  
               // NewTD = NewTR.insertCell(6);
               // strcombohtml = ''
                //NewTD.align = 'right';
                //strcombohtml = strcombohtml + '<%=CommonFunctions.HTMLControls.DrawTextBox("Work_" , "Work_", , 50, 20, , "Right", , , , , , , True, , , , , 1).ToString.Replace("'","\'") %>'
               // strcombohtml = strcombohtml.replace(/Work_/g, "Work_" + noOfRows)
               // NewTD.innerHTML = '<td>' + strcombohtml + '</td>';


                LastRowNumber = noOfRows;
                    }
                    });
    </script>--%>
  
   
   
</body>
</html>

