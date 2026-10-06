<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added by Vaijat K ON 18/05/2016 For Issue ID -*/
    .footerMenuTable {
        visibility:visible !important;
    }
    /*End of Addition by Vaijat K*/
</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectProfitBy_SiteRates.aspx.vb"  Inherits="PbNIT.ProjectProfitBy_SiteRates" %>
<HTML>
	<% CommonFunctions.General.PlotPageHeadTag("Role Rate Details")%>
	<body class="clsBody" onload="window_onload()" onresize="window_onresize()">
	 
		<form id="frmRoleRate" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
		
									
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		
        var objform=GetFormReference('frmRoleRate');
		var objDivMain=GetObjectReference('frmRoleRate','divRoleSection');	 
		
	function History_OnClick(UniqueID,TagID,IsSubTagID)
	{
    		window.open ("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID="+IsSubTagID+"&TagID="+TagID+"&UniqueID="+UniqueID+"&ProjectID=<%=m_lngProjectID%>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=700,height=500");
	}
	
	function window_onload()
	{
	    document.body.style.height = window.innerHeight - 3 + 'px';
	        var intDivHeight=0;

		    if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivMain.offsetTop - 37;
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 37;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
					
		        /*Commented And Added by KIRAN K K For Height Issue fixing*/
				//objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight+'px';
		        /*Commented And Added by KIRAN K K For Height Issue fixing*/
				
			}
	  }
	  function window_onresize()		
	{		
	      document.body.style.height = window.innerHeight - 3 + 'px';
		    var intDivHeight;
		    if(objDivMain)
		    {
		        //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 37;
		        if (navigator.appName=="Netscape") 
		        {
		            intDivHeight = window.innerHeight -  objDivMain.offsetTop - 37;
		        }
		        else
		        {
		            intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 37;
		        }
			    if (intDivHeight < 100)	intDivHeight = 100;
		        /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    objDivMain.style.height = intDivHeight;
			    objDivMain.style.height = intDivHeight+'px';
		        /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    
		    }
	   } 
	   
	   function Back_OnClick(From,IsOffShore)
	   {
	        if(From.toUpperCase()=="ROLE")
			    window.location.href="../General/CommonList.aspx?MasterTagID=3969&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1&Mode=&FromWhere=PM&IsOffShore="+IsOffShore;
			else
			    window.location.href="../General/CommonList.aspx?MasterTagID=3970&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1&Mode=&FromWhere=PM&IsOffShore="+IsOffShore;    
	    
	   }
	   
	   function Save_OnClick()
	   {
			
	   
	       if(!validateControl()) return;
	             
	       
			objform.action="../PRJPROFIT/ProjectProfitBy_SiteRates.aspx?Action=SAVE";
			objform.submit();
	   } 
	   
	   
	 
	   function DeleteItems_OnClick(TabIndex)
	   { 
	   
	   		var blnIsDelete=false;
	   		var blnMessage;
			
				var objDelete=GetObjectReference('frmRoleRate','chkDelete',true);
				if (objDelete!=null)
				{
					for(i=0;i<objDelete.length;i++)
					{
						if(objDelete[i].checked==true){
							blnIsDelete=true;
							break;
							}
							    
					}
				}
				blnMessage="Are you sure, you want to delete selected Item(s)?";	
			
				if(!blnIsDelete)
				{
				alert('Select atleast one rate item(s) for deletion !');
				return;
				}
	   
			if(confirm(blnMessage))
			{
				objform.action="../PRJPROFIT/ProjectProfitBy_SiteRates.aspx?Action=DELETE";
				objform.submit();
			}					
	   } 
	  
	
	  
	
	function CreateRowForRoleRate(From)
		{
			var strComboHTML;
			var strRoleComboHTML;
			//noOfRows = noOfRows + 1;
			var CellNo=0;
			var objTbl = GetObjectReference('frmRoleRate','tblRoleRate');
			var objItemCount = GetObjectReference('frmRoleRate','txtItemCount');
			var objtxtPreItemCount=GetObjectReference('frmRoleRate','txtPreItemCount');
			
			if (objItemCount!=null){
				intItemCount = parseInt(objItemCount.value);
			}
			if (objItemCount!=null){
				intPreItemCount = parseInt(objtxtPreItemCount.value);
			}
			
		  
		    strComboHTML = '<%=m_strComboboxHTML.Replace("'","\'") %>';	
		    
		    if(From.toUpperCase()=="RESOURCE")
		        strRoleComboHTML='<%=m_strRoleComboHTML.Replace("'","\'") %>';	
		    
			var startMandHTML = " ";
			var NewTR,newTD;
			var strFrequencyHTML;
			var strHTML;
			var strcombohtml;


			NewTR = objTbl.insertRow(intItemCount+1);

			NewTR.className = 'clsTRBlank';
			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='center';
			strHTML= "<td><IMG BORDER=0 src='../../images/delete.gif' onclick = 'deleteRow(this,"+intPreItemCount+")'>";
			NewTD.innerHTML= strHTML+"</td>";
			CellNo+=1;
			//Site
		
		    if('<%=m_blnSingleSite %>'!='True')
		    {
			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='left';
			strComboHTML = strComboHTML.replace(/cmbSite/g,"cmbSite_"+String(intPreItemCount));
			strComboHTML = strComboHTML.replace(/Site_OnChange/g,"Site_OnChange(this,"+String(intPreItemCount)+")");
		    
						
			NewTD.innerHTML = "<td>"+strComboHTML+"<IMG src='../../Images/Star.gif' border=0></td>";
			CellNo+=1;
			}
			//Role
			if(From.toUpperCase()=="RESOURCE")
			{
			    NewTD = NewTR.insertCell(CellNo);
			    NewTD.align='left';
			    strRoleComboHTML = strRoleComboHTML.replace(/cmbRole/g,"cmbRole_"+String(intPreItemCount));			    		    
    			strRoleComboHTML = strRoleComboHTML.replace(/Role_OnChange/g,"Role_OnChange(this,"+String(intPreItemCount)+")");
    						
			    NewTD.innerHTML = "<td>"+strRoleComboHTML+"</td>";
			    CellNo+=1;  
			}
			//From Date

			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='left';
			strFromDate='<%=m_StrFromDateHTML.Replace("'","\'")%>';
			strFromDate = strFromDate.replace(/dtFromDate/g,"dtFromDate_"+String(intPreItemCount));
			strFromDate = strFromDate.replace(/....images/g,"..\\..\\images\\");
			
			NewTD.innerHTML = "<td>"+strFromDate+"</td>";	
			CellNo+=1;
			//To Date
			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='center';
			NewTD.innerHTML =""
			/*strToDate='<%=CommonFunctions.HTMLControls.DrawDateControl("dtToDate"  , "dtToDate", , , , , "frmRoleRate", , , , True, , , True, ).Replace("'","\'")%>';
			strToDate = strToDate.replace(/dtToDate/g,"dtToDate_"+String(intPreItemCount));
			strToDate = strToDate.replace(/....images/g,"..\\..\\images\\");
			
			NewTD.innerHTML = "<td>"+strToDate+"</td>";	*/
			CellNo+=1;
			if(From.toUpperCase()=="RESOURCE" && ('<%=m_strContractType%>'=='3' || '<%=m_strContractType%>'=='7'))
			{
			}
			else{
			//Normal Rate	
			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='right';
			NewTD.innerHTML = "<td><label id=lblNR"+String(intPreItemCount)+ "></label><Input type=textbox name=txtNormalRate_"+String(intPreItemCount)+" id=txtNormalRate_"+String(intPreItemCount)+" value='' maxlength=10 class=clsTextBox style='width:100px;text-align: right;' /><IMG src='../../Images/Star.gif' border=0></IMG></td>";	
			CellNo+=1;
			if('<%=blnIsExtrHrsBilling %>'=='True')
			{
			//Extra Rate
			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='right';
			NewTD.innerHTML = "<td><label id=lblER"+String(intPreItemCount)+ "></label><Input type=textbox name=txtExtraRate_"+String(intPreItemCount)+" id=txtExtraRate_"+String(intPreItemCount)+" value='' maxlength=10 class=clsTextBox style='width:100px;text-align: right;' /><IMG src='../../Images/Star.gif' border=0></IMG></td>";	
			CellNo+=1;	
			
			//Holiday Rate	
			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='right';
			NewTD.innerHTML = "<td><label id=lblHR"+String(intPreItemCount)+ "></label><Input type=textbox name=txtHolidayRate_"+String(intPreItemCount)+" id=txtHolidayRate_"+String(intPreItemCount)+" value='' maxlength=10 class=clsTextBox style='width:100px;text-align: right;' /></td>";	
			CellNo+=1;
			}
			
			}
			//CTC
			//NewTD = NewTR.insertCell(7);
			//NewTD.align='right';
			//NewTD.innerHTML = "<td><label id=lblCTC"+String(intPreItemCount)+ "></label><Input type=textbox name=txtCTC_"+String(intPreItemCount)+" id=txtCTC_"+String(intPreItemCount)+" value='' class=clsTextBox style='width:100px;text-align: right;' /></td>";	
			
			
			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='left';
			NewTD.innerHTML ="";
			CellNo+=1;
				
			NewTD = NewTR.insertCell(CellNo);
			NewTD.align='center';
			NewTD.innerHTML ="";//"<td align=center><input type=checkbox class='clsCheckBox' name=chkSelect_" +String(intPreItemCount)+" id=chkSelect_" +String(intPreItemCount)+" value='0' style='text-align: right;'/></td>";			
			
			
           if(From.toUpperCase()=="RESOURCE")
           {
                Role_OnChange(null,intPreItemCount);
           } 
			setSectionRowCount(1,intPreItemCount);
			
			
		}
		function setSectionRowCount(flag,noOfRows)
		{
			var objtxtItems=GetObjectReference('frmRoleRate','txtItems');
			var objItemCount = GetObjectReference('frmRoleRate','txtItemCount');
			var objtxtPreItemCount=GetObjectReference('frmRoleRate','txtPreItemCount');
			
			if(flag==1)
			{
				if(objItemCount!=null){
					objItemCount.value=parseInt(objItemCount.value)+1;
					
				}
				if(objtxtItems!=null){
					objtxtItems.value=objtxtItems.value + noOfRows+",";
				}
				if(objtxtPreItemCount!=null){
					objtxtPreItemCount.value=parseInt(objtxtPreItemCount.value)+1;
				}	

					
			}
			else
			{
				if(objtxtItems!=null){
					objItemCount.value=parseInt(objItemCount.value)-1;
				}
				if(objtxtItems!=null){
					objtxtItems.value=objtxtItems.value.replace(noOfRows+",","");
				}
								
			}

		}
		function deleteRow(objImg, rowID)
		{   
		
			var objTbl = GetObjectReference('frmRoleRate','tblRoleRate');
			var objtxtItemCount=GetObjectReference('frmRoleRate','txtItemCount');
			var rowNo=objImg.parentElement.parentElement.rowIndex
			
			objTbl.deleteRow(rowNo);
			setSectionRowCount(0,rowID);
		}
	    
	    function Site_OnChange(obj,RowNo)
	    {
	  
	       var objSC=GetObjectReference('frmRoleRate','cmbSiteCurrency');
	       var objlblNR=GetObjectReference('frmRoleRate','lblNR'+RowNo);
	       var objlblER=GetObjectReference('frmRoleRate','lblER'+RowNo);
	       var objlblHR=GetObjectReference('frmRoleRate','lblHR'+RowNo);
	      // var objlblCTC=GetObjectReference('frmRoleRate','lblCTC'+RowNo);
	       
	       
	       var objSelectedRole=GetObjectReference('frmRoleRate','cmbRole_'+RowNo);
	         	
	       if(objSC!=null)
	       {	
	       
	           if(objlblNR!=null)	       
	            objlblNR.innerHTML=objSC.options[obj.selectedIndex].text;
    	           	       
	           if(objlblER!=null)	        
	            objlblER.innerHTML=objSC.options[obj.selectedIndex].text;
	            
	            if(objlblHR!=null)	       
	            objlblHR.innerHTML=objSC.options[obj.selectedIndex].text;
    	       	       
	           //if(objlblCTC!=null)	        
	            //objlblCTC.innerHTML=objSC.options[obj.selectedIndex].text;
	       }     
	     
	             
	       Role_OnChange(objSelectedRole,RowNo);
	    }
	    function validateControl()
	{
		var arrNewRateIDs = new Array();
		var arrDuplicatID= new Array();
		var arrSiteID=new Array();
		var count=0;
		var objtxtItems=GetObjectReference('frmRoleRate','txtItems');
		var objtxtNR,objtxtER,objcmbSite,objdtFromDate,objProjectStartDate,objtxtHR,objtxtCTC;
		var objcmbRole;
		arrNewRateIDs=String(objtxtItems.value).split(",")
        objProjectStartDate=GetObjectReference('frmRoleRate','dtProjectStartDate');
        var objdtProjectEndDate=GetObjectReference('frmRoleRate','dtProjectEndDate');
		var objdtResourceLeavingDate=GetObjectReference('frmRoleRate','dtResourceLeavingDate');
		// For Database value validation
		for (i=0;i<arrRoleRateID.length;i++)
		{
		    objSiteID= GetObjectReference('frmRoleRate','cmbSite'+ arrRoleRateID[i]);
			objtxtNR= GetObjectReference('frmRoleRate','txtNormalRate'+ arrRoleRateID[i]);
			objtxtER= GetObjectReference('frmRoleRate','txtExtraRate'+ arrRoleRateID[i]);
			objtxtHR= GetObjectReference('frmRoleRate','txtHolidayRate'+ arrRoleRateID[i]);
			//objtxtCTC= GetObjectReference('frmRoleRate','txtCTC'+ arrRoleRateID[i]);
			
			objdtFromDate= GetObjectReference('frmRoleRate','FFE29587WHIZ_dtFromDate'+ arrRoleRateID[i]);
		    
		
		    if(objdtFromDate!=null)
		    {
		       arrDuplicatID[count]=objdtFromDate.value;
		       arrSiteID[count]=objSiteID.value;
		       count+=1; 
		    }
		    
				if (disallowBlank(objtxtNR,'&#39;Normal Rate &#39; should not be left blank.',true) )
					{return false; }		   
				if(objtxtNR!=null)
				{
				    if(parseFloat(objtxtNR.value)==0)
				    {alert('Normal Rate should be greater than zero (0) !');setFocus(objtxtNR); return false;}
				}	
				if (disallowNonNumeric(objtxtNR,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objtxtNR,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}	
		
	            
	    
				if (disallowBlank(objtxtER,'&#39;Extra Rate &#39; should not be left blank.',true) )
					{return false; }		   
				if (disallowNonNumeric(objtxtER,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objtxtER,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}	
		
	            if (disallowNonNumeric(objtxtHR,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objtxtHR,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}	
				
				/*if (disallowNonNumeric(objtxtCTC,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objtxtCTC,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}	*/
	
		}


		//For newly added value validation
		for(i=0;i<arrNewRateIDs.length-1;i++)
		{
		    objcmbSite=GetObjectReference('frmRoleRate','cmbSite_'+ arrNewRateIDs[i]);
		    objcmbRole=GetObjectReference('frmRoleRate','cmbRole_'+ arrNewRateIDs[i]);
		    objtxtDefaultSite=GetObjectReference('frmRoleRate','txtDefaultSite');
		    objdtFromDate= GetObjectReference('frmRoleRate','dtFromDate_'+ arrNewRateIDs[i]);
			objtxtNR= GetObjectReference('frmRoleRate','txtNormalRate_'+ arrNewRateIDs[i]);
			objtxtER= GetObjectReference('frmRoleRate','txtExtraRate_'+ arrNewRateIDs[i]);
			objtxtFromDate= GetObjectReference('frmRoleRate','FFE29587WHIZ_dtFromDate_'+ arrNewRateIDs[i]);
		    objtxtHR= GetObjectReference('frmRoleRate','txtHolidayRate_'+ arrNewRateIDs[i]);
														
		//	objtxtCTC= GetObjectReference('frmRoleRate','txtCTC_'+ arrRoleRateID[i]);
		
		    if(objtxtFromDate!=null)
		    {
		       arrDuplicatID[count]=objtxtFromDate.value;
		       if(objcmbSite!=null)
		            arrSiteID[count]=objcmbSite.value;
		       if(objtxtDefaultSite!=null)
		             arrSiteID[count]=objtxtDefaultSite.value;
		       count+=1; 
		    }
		        if (disallowBlank(objcmbSite,'&#39;Site &#39; should not be left blank.',true) )
					{return false; }
							   
		        if (disallowBlank(objcmbRole,'&#39;Role &#39; should not be left blank.',true) )
					{return false; }
					
		        if (disallowBlank(objdtFromDate,'&#39;Effective From Date &#39; should not be left blank.',true))
					{return false; }	
			
						
				if(disallowDate1LessThanDate2(objdtFromDate,objProjectStartDate,"&#39;Effective From Date should not be less than Project Start Date ['"+ objProjectStartDate.value +"'].&#39;",true))		   
				{return false;}	
				
				if(disallowDate1GreaterThanDate2(objdtFromDate,objdtProjectEndDate,"&#39;Effective From Date should not be greater than Project End Date ['"+ objdtProjectEndDate.value +"'].&#39;",true))		   
				{return false;}	
				
				if(disallowDate1GreaterThanOrEqualToDate2(objdtFromDate,objdtResourceLeavingDate,"&#39;Effective From Date should not be greater than Resource Leaving Date ['"+ objdtResourceLeavingDate.value +"'].&#39;",true))		   
				{return false;}	
			
				
		        if (disallowBlank(objtxtNR,'&#39;Normal Rate &#39; should not be left blank.',true) )
					{return false; }
				
				if(objtxtNR!=null)
				{
				    if(parseFloat(objtxtNR.value)==0)
				    {alert('Normal Rate should be greater than zero (0) !');setFocus(objtxtNR); return false;}
				}			
				   
				if (disallowNonNumeric(objtxtNR,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objtxtNR,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}	
		
	
	    
				if (disallowBlank(objtxtER,'&#39;Extra Rate &#39; should not be left blank.',true) )
					{return false; }		   
				if (disallowNonNumeric(objtxtER,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objtxtER,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}	
			
			      if (disallowNonNumeric(objtxtHR,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objtxtHR,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}	
				
				/*if (disallowNonNumeric(objtxtCTC,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objtxtCTC,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}*/
		}	
	
	  
		for(i=0;i< arrDuplicatID.length;i++)
		{
		 for(j=0;j<arrDuplicatID.length;j++)
		 {
		   if(i!=j)
		   {
		   if('<%=m_strFrom.ToUpper %>'=='ROLE')
		   { 
		   //Commented and added by ShraddhaM for validation
		   //Validation : Role cannot be on site for same date 
		    //if(arrDuplicatID[i]==arrDuplicatID[j] && arrSiteID[i]==arrSiteID[j])
		    if(arrDuplicatID[i]==arrDuplicatID[j])
		    //Ended by ShraddhaM
		    {
			 //Commented and added by ShraddhaM for validation
		     //Validation : Role cannot be on site for same date 
			 //alert("Effective From Date should not be same for same site !");
			 alert("Effective From Date should not be same for the same role !");
			 //Ended by ShraddhaM
			 return false;
		    }
		   }
		   else
		   {
		   
		    if(arrDuplicatID[i]==arrDuplicatID[j])
		    {
			 alert("'Effective From Date' already exists !");
			 return false;
		    }
		   } 
		  } 
		  } 
		}
		return true;
	}
	function Role_OnChange(objSelectedRole,intRow)
	{
	  
	     var  objcmbHidRoleRate=GetObjectReference('frmRoleRate','cmbHidRoleRate');
	     var objcmbSite=GetObjectReference('frmRoleRate','cmbSite_'+ intRow);
	     
	     if(objcmbSite==null)
	         objcmbSite=GetObjectReference('frmRoleRate','txtDefaultSite');
	       
	     if(objSelectedRole==null)
	        objSelectedRole=GetObjectReference('frmRoleRate','cmbRole_'+intRow);
	        
	     var  objtxtNR= GetObjectReference('frmRoleRate','txtNormalRate_'+ intRow);
		 var  objtxtER= GetObjectReference('frmRoleRate','txtExtraRate_'+ intRow);
			
		  var  objtxtHR= GetObjectReference('frmRoleRate','txtHolidayRate_'+ intRow);
	      var dblRate=0;
	      
	      if(objSelectedRole!=null)
	      {
	      for(i=0;i<objcmbHidRoleRate.length;i++)
	      {
	        if(String(objcmbSite.value)==String(objcmbHidRoleRate[i].value))
	        {
	            var arrRate=String(objcmbHidRoleRate[i].text).split(",")
	            
	            if(String(objSelectedRole.value)==String(arrRate[0]))
	            {
	                    dblRate=parseFloat(arrRate[1]);
	                    break;
	            }
	       }
	      }
	    
	     if(objtxtNR!=null)
	        objtxtNR.value=dblRate;
	     
	      if(objtxtER!=null)  	    
	        objtxtER.value=dblRate;
	   
	       // objtxtHR.value=dblRate;
	     }   
	      
	}
		</script>
	</body>
</HTML>
