



<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->
<%--Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
<%--<script src="../../responsive/jquery/jquery-2.1.3.min.js" type="text/javascript"></script>--%>
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("")%> 
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
<%--<script type="text/javascript" src="../../responsive/responsive.js"></script>--%>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        width: 35%;
        vertical-align: middle;
    }
        /*Added by Kiran for Loader 27/11/15*/
    #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 50%;
        padding: 30px 15px 0px;
        border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;
        background: url("../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
        width:100px;
        height: 100px;
        /*z-index: 99;
            height: 100%;*/
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
    }

    #fillDiv {
        opacity: 0.4;
        background-color: ghostwhite;
        /*DISPLAY: none;*/
        Z-INDEX: 100;
        LEFT: 0px;
        VISIBILITY: visible;
        WIDTH: 100%;
        POSITION: absolute;
        TOP: 0px;
        HEIGHT: 100%;
        float: right;
    }
    /*Added By Dipali V On 30th Dec 2020 For Scolling Page Issue*/
    #DivList {
        height:450px!important;
        overflow:auto!important;
    }
   
    /*Added by Kiran for Loader 27/11/15*/
</style>

<script type="text/javascript">
    // Added by Kiran for Loader 27/11/15
    $(document).ready(function () {

        //$("HTML").append("<div id='preloader'></div>");
        //$("HTML").append("<div id='fillDiv'></div>"); 
    });
   
 
    function RemoveFrameLoader() {
        //jQuery("#preloader").remove();
        //jQuery("#fillDiv").remove();
        //jQuery("#preloader").fadeOut("slow");
        //jQuery("#fillDiv").fadeOut("slow");

        $("#preloader").hide();
        $("#fillDiv").hide();
        $("#preloader").fadeOut("slow");
        $("#fillDiv").fadeOut("slow");
 
    }

    //Added & Commented By Dipali V On 28th Dec 2020 For JQuery Version Change
    //$(window).load(function () {
    //    RemoveFrameLoader();
    //});
    $(window).on("load", function () {
       RemoveFrameLoader();
    });

    $(window).on("resize", function () {
       RemoveFrameLoader();
    });
     //Added & Commented By Dipali V On 28th Dec 2020 For JQuery Version Change
    //End by KIran for Loader 27/11/15
    //$(document).ready(function () {

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:12/02/2015
    //    /*---------------------------------------------------------*/
    //    responsiveTopMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    //    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:19/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveFooterMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    //    /*---------------------------------------------------------*/
       
    //});


    //$(window).on("resize", function () {
    //    RemoveFrameLoader();
    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:12/02/2015
    //    /*---------------------------------------------------------*/
    //    responsiveTopMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    //    // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:12/02/2015
    //    /*---------------------------------------------------------*/
    //    responsiveFooterMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //});

</script>

<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RoleAccess.aspx.vb" Inherits="Whiz.RoleAccess" %>

<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class='clsBody' MS_POSITIONING="GridLayout" > <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
	<script language="javascript">
	//Added By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
	function RefreshParent()
	{ 

            /*
            Function Name   :   RefreshParent
            Desc            :   To refresh parent 
            Author          :   NinadP
            Created         :   14 July 2009
            ReqID           :   WAF3_PB_74 Tab Collection enhancement
            */
            try{//debugger;
                var url;
                var query;
                url =  window.opener.location.href.substring(0,window.opener.location.href.indexOf(window.opener.location.search)) + '?'; 
                query = window.opener.location.search.substring(1);

                var parms = query.split('&');
                for (var i=0; i<parms.length; i++) 
                {
                    var pos = parms[i].indexOf('=');
                    var key = parms[i].substring(0,pos);
                    if (key != 'Action')
                    {
                        url += parms[i] + '&'
                    }
                } 
                url=url.substring(0,url.length -1);
                //window.opener.location.href =  url;
                window.opener.document.forms['frmRoleAccess'].action =  url;
                window.opener.document.forms['frmRoleAccess'].submit();
             }catch(e){}
            }
            //End Addition By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
	</script>
		 <form id="frmRoleAccess" name="frmRoleAccess" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
			var objdivlist;
			var objform;
							
			objform=GetFormReference('frmRoleAccess');
			objdivlist=GetObjectReference('frmRoleAccess','DivList');
				
			<%MyBase.InitializeResources("Resources.RoleAccess", "Resources")%>;
<% 'WAF3_PB_42 April 10, 2007 Removed local functions window_onresize and window_onload %>

			function Save_OnClick(ACTION)
			{
			 
			
				var objTxt,count;
				
				objTxt = GetObjectReference('frmRoleAccess','hdtxtRowCount');
				count = objTxt.value;
				
				if(count > 0)
				{
					objform.action = "RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&RoleID=<%=m_lngUserAccessID%>&Action=" + ACTION + "&TagID=<%=m_lngTagID%>&ModuleID=<%=m_strTemplateID%>";
					objform.submit();
				}
			}
			 //Modified By Ninad on 17 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
			function ClearAll_OnClick()
			{
                var ele=null;
                ele=document.getElementsByTagName("input");
                if(ele!=null)
	            {
	                for ( i=0; i < ele.length; i++ ) 
	                {
	                    if(ele[i].type=='checkbox')
	                    {
                           if (ele[i].value!='')
                           {
    	                        if (ele[i].id.substring(0,9).toUpperCase()!='CHKACCESS')
        	                        ele[i].disabled = true;
	                            ele[i].checked = false;	
	                        }    
	                    }    
	                }
	            } 
			}
			function SelectAll_OnClick()
			{
                var ele=null;
                ele=document.getElementsByTagName("input");
                if(ele!=null)
	            {
	                for ( i=0; i < ele.length; i++ ) 
	                {
	                    if(ele[i].type=='checkbox')
	                    {
                           if (ele[i].value!='')
                           {
           	                    ele[i].disabled = false;
	                            ele[i].checked = true;	
	                       }    
	                    }    
	                }
	            } 
            }
            //End Modification By Ninad on 17 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
			function Module_OnChange()
			{
			    //Edited by KIran for Loader 27/11/15
			    $("HTML").append("<div id='preloader'></div>");
			    $("HTML").append("<div id='fillDiv'></div>");
			    // Edited End by KIran for Loader 27/11/15
				objform.action = "RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&RoleID=<%=m_lngUserAccessID%>";
				objform.submit();
			}
			function Access_OnClick(indx)
			{//debugger;
				var objChkAdd,objChkEdit,objChkDel,objChkView;
				var objChkAccess,objModule;
				
				objModule = GetObjectReference('frmRoleAccess','cboModule');
                if (objModule != null && objModule.value =='BTSBTS')
				{
					objChkAccess = GetObjectReference('frmRoleAccess','chkAccess');
					objChkAdd = GetObjectReference('frmRoleAccess','chkAdd');
					objChkEdit = GetObjectReference('frmRoleAccess','chkEdit');
					objChkDel = GetObjectReference('frmRoleAccess','chkDelete');
					objChkView = GetObjectReference('frmRoleAccess','chkView');
									
					objChkAdd.disabled = !objChkAccess.checked;
					objChkEdit.disabled = !objChkAccess.checked;
					objChkDel.disabled = !objChkAccess.checked;
					objChkView.disabled = !objChkAccess.checked;
					
					objChkAdd.checked = objChkAccess.checked;
					objChkEdit.checked = objChkAccess.checked;
					objChkDel.checked = objChkAccess.checked;
					objChkView.checked = objChkAccess.checked;
				}
				else
				{//Added By Ninad on 18 May 2009 IssueID-30417
					if (isNaN(indx))				
					{
					    var objChk=GetObjectEvent(indx);
					    try
					    {
					        document.getElementById('chkAdd' + objChk.value).checked = objChk.checked;
					        document.getElementById('chkEdit' + objChk.value).checked = objChk.checked;					        
					        document.getElementById('chkDelete' + objChk.value).checked = objChk.checked;
					        document.getElementById('chkView' + objChk.value).checked = objChk.checked;					        					        
					    }catch(e){}
					    var objRows=document.getElementsByName(objChk.name + arguments[1] + 'TR')
    				    for (var i=0; i<objRows.length; i++) 
                        {
                            var ele=null;
                            ele=objRows[i].all
                            if(ele!=null)
	                        {
	                            for ( j=0; j < ele.length; j++ ) 
	                            {
	                                if(ele[j].type=='checkbox')
	                                {
	                                    if (ele[j].value!='')
	                                    {
	                                        if (ele[j].id.substring(0,9).toUpperCase()!='CHKACCESS')
    	                                        ele[j].disabled = !objChk.checked;
	                                        ele[j].checked = objChk.checked;
	                                    }    
	                                }    
	                            }
	                        } 
       				    }
					}
					else
					{
					var objChk=GetObjectEvent(arguments[1]);
					//Modified By Ninad on 13 July 2009 ReqID-WAF3_PB_74
					objChkAdd = GetObjectReference('frmRoleAccess','chkAdd',true);
					if(objChkAdd.length>0)
					{
					    objChkEdit = GetObjectReference('frmRoleAccess','chkEdit',true);
					    objChkDel = GetObjectReference('frmRoleAccess','chkDelete',true);
					    objChkView = GetObjectReference('frmRoleAccess','chkView',true);
   					    objChkAdd[indx].disabled = !objChk.checked;
					    objChkEdit[indx].disabled = !objChk.checked;
					    objChkDel[indx].disabled = !objChk.checked;
					    objChkView[indx].disabled = !objChk.checked;
    					
					    objChkAdd[indx].checked = objChk.checked;
					    objChkEdit[indx].checked = objChk.checked;
					    objChkDel[indx].checked = objChk.checked;
					    objChkView[indx].checked = objChk.checked;
					}
					else
					{
					    objChkAdd = GetObjectReference('frmRoleAccess','chkAdd' + objChk.value);					
					    objChkEdit = GetObjectReference('frmRoleAccess','chkEdit' + objChk.value);
					    objChkDel = GetObjectReference('frmRoleAccess','chkDelete' + objChk.value);
					    objChkView = GetObjectReference('frmRoleAccess','chkView' + objChk.value);
   					    objChkAdd.disabled = !objChk.checked;
					    objChkEdit.disabled = !objChk.checked;
					    objChkDel.disabled = !objChk.checked;
					    objChkView.disabled = !objChk.checked;
    					
					    objChkAdd.checked = objChk.checked;
					    objChkEdit.checked = objChk.checked;
					    objChkDel.checked = objChk.checked;
					    objChkView.checked = objChk.checked;
					}					
					//End Modification By Ninad on 13 July 2009 ReqID-WAF3_PB_74					
					//End Addition By Ninad on 18 May 2009 IssueID-30417
					}
					
				}
			}
			function ConfigureSubtag_OnClick(tagid)
			{
				var strModule="";
				var objModule = GetObjectReference('frmRoleAccess','cboModule');
				strModule = objModule.value;
				
				if(strModule!="" && strModule!=null)
				{
					if("<%=m_strMode.ToUpper%>"=="<%=CONST_ROLE_ACCESS%>")
					{
						window.open("RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=CONST_SUBNODE_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&TagID=" + tagid + "&ModuleID=" + strModule,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-550)/2 + ",width=550,height=550");
					}
					else 
					{
						window.open("RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=CONST_SUBNODE_ACCESS_GROUP%>&RoleID=<%=m_lngUserAccessID%>&TagID=" + tagid + "&ModuleID=" + strModule,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-550)/2 + ",width=550,height=550");
					}
				}
			}
			//Added By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
			function ConfigureTabCollection_OnClick(tagid,strModule)
			{
					if("<%=m_strMode.ToUpper%>"=="<%=CONST_ROLE_ACCESS%>" || "<%=m_strMode.ToUpper%>"=="<%=CONST_TABCOLLECTION_ROLE_ACCESS%>")
					{
						window.open("RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=CONST_TABCOLLECTION_ROLE_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&TagID=" + tagid + "&ModuleID=" + strModule ,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-600)/2 + ",width=600,height=600");
					}
					else 
					{
						window.open("RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=CONST_TABCOLLECTION_GROUP_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&TagID=" + tagid + "&ModuleID=" + strModule ,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-600)/2 + ",width=600,height=600");
					}
			}			
			function TabCollectionLink_OnClick(ModuleID,STID)
			{
				window.open("RoleAccess.aspx?ModuleID=" + ModuleID + "&Mode=<%=CONST_TAG_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&TagID=" + STID + "&SubTagID=" + STID + "&SubMode=<%=m_strMode.ToString%>","","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-400)/2 + ",top=" + (window.screen.height-250)/2 + ",width=400,height=250");			
			}
			function TabCollectionConfigureSubtag_OnClick(strModule,tagid)
			{
				if(strModule!="" && strModule!=null)
				{
					if("<%=m_strMode.ToUpper%>"=="<%=CONST_TABCOLLECTION_ROLE_ACCESS%>")
					{
						window.open("RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=CONST_SUBNODE_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&TagID=" + tagid + "&ModuleID=" + strModule,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-550)/2 + ",width=550,height=550");
					}
					else 
					{
						window.open("RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=CONST_SUBNODE_ACCESS_GROUP%>&RoleID=<%=m_lngUserAccessID%>&TagID=" + tagid + "&ModuleID=" + strModule,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-550)/2 + ",width=550,height=550");
					}
				}
			}

            //End Addition By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement			
			function Back_OnClick()
			{
				if("<%=m_strMode.ToUpper%>"=="<%=CONST_SUBNODE_ACCESS_GROUP%>")
				{
					objform.action = "RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=CONST_GROUP_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&ModuleID=<%=m_strTemplateID%>";
					objform.submit();
				}
				else
				{
					objform.action = "RoleAccess.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=CONST_ROLE_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&ModuleID=<%=m_strTemplateID%>";
					objform.submit();
				}
			}
			
			function Link_OnClick(TID,STID)
			{
				var objModule;
				objModule = GetObjectReference('frmRoleAccess','cboModule');
				window.open("RoleAccess.aspx?ModuleID=" + objModule.value + "&Mode=<%=CONST_TAG_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&TagID=" + STID + "&SubTagID=" + STID + "&SubMode=<%=m_strMode.ToString%>","","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-400)/2 + ",top=" + (window.screen.height-250)/2 + ",width=400,height=250");			
			}
			function TagSave_OnClick(ACTION)
			{
				objform.action = "RoleAccess.aspx?ModuleID=<%=m_strTemplateID%>&Mode=<%=CONST_TAG_ACCESS%>&RoleID=<%=m_lngUserAccessID%>&TagID=<%=m_lngTagID%>&Action=" + ACTION + "&SubMode=<%=m_strSubMode%>";
				objform.submit();
			}
			
			function InheritSave_OnClick(ACTION)
			{
	    		var save;
				var cboSource,cboDestination;
				
				cboSource = GetObjectReference('frmRoleAccess','cboSourceRole');
				cboDestination = GetObjectReference('frmRoleAccess','cboDestinationRole');
				
				save = disallowBlank(cboSource,'<%=MyBase.GetResourceString("MSG_EMPTY_SOURCEROLE")%>',true);		
				if(save==false)
				{
					save = disallowBlank(cboDestination,'<%=MyBase.GetResourceString("MSG_EMPTY_DESTINATIONROLE")%>',true);		
					if(save==false)	
					{
					<% 'Req ID  :   2.0.42-SP4-WAF%> 
					if(cboSource.value==cboDestination.value)
						{
							alert('<%=m_strValidationMsgSourceDestinationSame%>');
							setFocus(cboDestination);
							return ;
						}
						objform.action = "RoleAccess.aspx?Mode=<%=m_strMode%>&Action=" + ACTION ;<%'Modified By Shrikant B On 15 Jan 2009 For Issue Id 26582 %>
						objform.submit();
					}
				}				
			}
			
			function OtherLink_OnClick()
			{
				var strModuleID;
				var objCbo;
				
				objCbo = GetObjectReference('frmRoleAccess','cboModule');
				strModuleID = objCbo.value;
				
				window.open("SM_OtherLinks.aspx?ModuleID=" + strModuleID + "&RoleID=<%=m_lngRoleID%>","","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
			}
        </script>
       </body>
</HTML>

