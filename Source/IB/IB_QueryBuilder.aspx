<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_QueryBuilder.aspx.vb" Inherits="PbNIT.IB_QueryBuilder"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
    <meta http-equiv='X-UA-Compatible' content='IE=7,8,9,edge' />

	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	

<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
	<form id="frmQueryBuilder" name="frmQueryBuilder" method="post" runat="server">
		<%PageInit()%>
	</form>
   <link href="../General/loaderStylesheet.css" rel="stylesheet" />
	<script language="javascript">
			var objdivlist;
			var objform;
			var intLength;
			var arrNames;
			var objValue;
			var objCalendar;
			var intCounter=0;
			var intEditableDateControl
			//Added by PrashantD on 2 April 2007 for IssueID 11391 
			var objFFE29587WHIZ_txtCustomFieldDate;
			//End of addition by PrashantD on 2 April 2007
			
			objform = GetFormReference('frmQueryBuilder');
			objdivlist = GetObjectReference('frmQueryBuilder','DivList');
			 	
			intLength = <%=m_arrQueryName.Length%>;
			arrNames = new Array(intLength);
			
			<%For m_intCnt = 0 to m_arrQueryName.Length-1%>
				arrNames[<%=m_intCnt%>] = "<%=m_arrQueryName(m_intCnt)%>";
			<%Next%> 
			//= frmTaskDetails.txtBlankField.cloneNode(true)
			   
			'<%MyBase.InitializeResources("AppResources.IB_QueryBuilder", "AppResources")%>';
			
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				var queryStatus;
				var objTxt;
				
				//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
				if (intDivHeight < 100)
				intDivHeight = 100;
				objdivlist.style.height = intDivHeight	+'px';	
				
				objValue = GetObjectReference('frmQueryBuilder','txtValue');
				objCalendar = GetObjectReference('frmQueryBuilder','imgCalendar');
				
				queryStatus = new String('<%=m_strIsValidQuery%>');
				
				if(queryStatus.toUpperCase()=='NO')
				{					
					alert('<%=mybase.GetResourceString("MSG_INVALID_QUERY")%>');					
					objTxt = GetObjectReference('frmQueryBuilder','txtQueryName');
					objTxt.focus();
				}
				if('<%=m_strMode%>'=='<%=CONST_QUERY_DETAILS%>')
				{
					objTxt = GetObjectReference('frmQueryBuilder','txtQueryName');
					objTxt.focus();
				}
				
				//Addition by PrashantD on 13 March 2007 for IssueID 11573
				//script to refresh parent
				if('<%=Request.QueryString("Action")%>'=='<%=CONST_ACTION_EXECUTE%>')
				{
					
					var openerHref = opener.location.href;
					openerHref = replaceSubstring(openerHref,"Mode=Default","");
					if (openerHref.indexOf("cboQuery") == -1)
					openerHref=openerHref +'&cboQuery='+GetObjectReference('frmQueryBuilder','cboQuery').value;
					else
					{
						
						var strcboQuery = openerHref.substring(openerHref.indexOf('cboQuery'),openerHref.length);
						
						if(strcboQuery.indexOf('&')==-1) 
						{
							openerHref = replaceSubstring(openerHref,'cboQuery='+strcboQuery.substring(9,strcboQuery.length),'cboQuery='+GetObjectReference('frmQueryBuilder','cboQuery').value);
						}
						else
						
						openerHref = replaceSubstring(openerHref,'cboQuery='+strcboQuery.substring(9,strcboQuery.indexOf('&')),'cboQuery='+GetObjectReference('frmQueryBuilder','cboQuery').value);
				
					}
					
					opener.location.href = openerHref;
					
					//opener.location.href = opener.location.href ;
               }
                //End of addition by PrashantD on 13 March 2007 for IssueID 11573
				
				
			}
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight +'px'	;	
			}
			function Paging_OnClick(strAlphabet)
			{
				
				objform.action = "IB_QueryBuilder.aspx?Mode=<%=m_strMode%>&Alphabet=" + strAlphabet; 
				objform.submit();  		
			}
			function SetDefault_OnClick(QID)
			{
			    //Commented and added by Yogesh J on 02-Feb-2016 to generate Token
        		//objform.action = "IB_QueryBuilder.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SETDEFAULT%>&Alphabet=<%=m_strAlphabet%>&QueryID=" + QID; 
			  //  objform.submit();  	
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'IB_QueryBuilder.aspx/GenrateURLToken_Query_OnClick',
			        data: JSON.stringify({ QueryID: QID, EmployeeID: "<%=Session("intUserID")%>" }),
			        success: function (Result) {   
			            objform.action = "IB_QueryBuilder.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SETDEFAULT%>&Alphabet=<%=m_strAlphabet%>&PKToken="+Result.d+"&QueryID=" + QID; 
			            objform.submit();  	
			        },
			        error: function () {
			      //      alert("Error")
			        }
			    });
			    //End of addition by Yogesh J on 02-Feb-2016 to generate Token
			  
			}
			function Execute_OnClick()
			{
				var objView,objQuery;
				
				objQuery = GetObjectReference('frmQueryBuilder','cboQuery');
				if(objQuery.value=='') 
				{
					alert('<%=mybase.getresourcestring("MSG_QUERY_NOT_SELECTED")%>');
					return;
				}
				objView = GetObjectReference('frmQueryBuilder','cboView');
				if(objView.value=='') 
				{
					alert('<%=mybase.getresourcestring("MSG_VIEW_NOT_SELECTED")%>');
					return;
				}
				
				objform.action = "IB_QueryBuilder.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_EXECUTE%>&Alphabet=<%=m_strAlphabet%>"; 
				
				objform.submit();  		
			}
			function Delete_OnClick()
			{
				var objChk,objTxt,intCnt;
				var i,Selected;
				objChk = GetObjectReference('frmQueryBuilder','chkDelete',true);
				objTxt = GetObjectReference('frmQueryBuilder','hdtxtRowCount');
				intCnt = objTxt.value;
				
				if(intCnt>0)
				{
					for(i=0;i<intCnt;i++)
					{
						if(objChk[i].checked==true) 
						{
							Selected=true;
							break;
						}
					}
					
					if(Selected==true)
					{
						if((window.confirm('<%=mybase.getresourcestring("MSG_DELETE_CONFIRM")%>'))==true)
						{
							
							objform.action = "IB_QueryBuilder.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&Alphabet=<%=m_strAlphabet%>"; 
							objform.submit();  		
						}
					}
					else
						alert('<%=mybase.getresourcestring("MSG_DELETE_QUERY_NOT_SELECTED")%>');
				}
			}
			function ExecuteQuery_OnClick()
			{
				var objChk,objTxt,intCnt;
				var i,Selected;
				var strQueryIDs;
				objChk = GetObjectReference('frmQueryBuilder','chkExecute',true);
				objTxt = GetObjectReference('frmQueryBuilder','hdtxtRowCount');
				intCnt = objTxt.value;
				
				if(intCnt>0)
				{
					strQueryIDs="";
					for(i=0;i<intCnt;i++)
					{
						if(objChk[i].checked==true) 
						{
							Selected=true;
							strQueryIDs = strQueryIDs + objChk[i].value + ",";
						}
					}
					
					if(Selected==true)
						window.open("IB_QueryExecute.aspx?QueryIDList=" + strQueryIDs ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-650)/2 + ",top=" + (window.screen.height-240)/2 + ",width=650,height=240");
					else
						alert('<%=mybase.getresourcestring("MSG_EXECUTE_QUERY_NOT_SELECTED")%>');
				}
			}
			function Query_OnClick(QID)
			{
                //Commented and added by Yogesh J on 02-Feb-2016 to generate Token
			    //objform.action = "IB_QueryBuilder.aspx?Mode=<%=CONST_QUERY_DETAILS%>&Alphabet=<%=m_strAlphabet%>&QueryID=" + QID; 
			   //  objform.submit();  
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'IB_QueryBuilder.aspx/GenrateURLToken_Query_OnClick',
			        data: JSON.stringify({ QueryID: QID, EmployeeID: "<%=Session("intUserID")%>" }),
			        success: function (Result) {   
			           objform.action = "IB_QueryBuilder.aspx?Mode=<%=CONST_QUERY_DETAILS%>&Alphabet=<%=m_strAlphabet%>&PKToken="+ Result.d +"&QueryID=" + QID; 
			            objform.submit();  
			        },
                     error: function () {
                     //    alert("Error")
                     }
			    });
			    //End of addition by Yogesh J on 02-Feb-2016
			}
			function Apply_OnClick()
			{
				var objTxt,flag;
				var strValue,cnt;
				var strquery,intPos,strCheckQuery;
				
				objTxt = GetObjectReference('frmQueryBuilder','txtQueryText');
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_QUERY_TEXT_EMPTY")%>',true);
				if(flag==false)
				{				
					//check for comment(--) and "'" in the text, if present then dont save.
					strValue = objTxt.value;
												
					strquery = new String(strValue);
					
					while(strquery.indexOf('--') != -1)
					{
						var retVal;
						
						intPos = strquery.indexOf('--');
						strCheckQuery = strquery.substring(1,intPos+2);
						strquery = strquery.substring(intPos+2);
						retVal = CheckComment(strCheckQuery);
						
						if(retVal==1)
						{
							flag=true;
							alert('<%=MyBase.GetResourceString("MSG_COMMENT")%>');	
							return;		
						}
						else if(retVal==2)
						{
							intPos = strquery.indexOf("'");				
							strquery = strquery.substring(intPos + 1);
						}
						else
							return;						
					}										
				//'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 	
				//Code Added By PradipK 15 Feb 2006
				if( formatQuery(strValue,'COMPLEXITY') == true)
					{						
					//End Addition By PradipK 15 Feb 2006
					if( formatQuery(strValue,'PRIORITY') == true)
					{
						if( formatQuery(strValue,'SEVERITY') == true)
						{	
							if( formatQuery(strValue,'STATUS') == true)
							{
								flag=false;
							}
							else
							{
								flag=true;
								alert("'CORPORATESTATUS' " + "<%=MyBase.GetResourceString("MSG_CORPORATE_FIELD_NAME")%>");	
								return;
							}
						}
						else
						{
							flag=true;
							alert("'CORPORATESEVERITY' " + "<%=MyBase.GetResourceString("MSG_CORPORATE_FIELD_NAME")%>");	
							return;
						}
					}
					else
					{
						flag=true;
						alert("'CORPORATEPRIORITY' " + "<%=MyBase.GetResourceString("MSG_CORPORATE_FIELD_NAME")%>");	
						return;
					}
					//Code Added By PradipK 15 Feb 2006				
					}
					else
					{
						flag=true;
						alert("'CORPORATECOMPLEXITY' " + "<%=MyBase.GetResourceString("MSG_CORPORATE_FIELD_NAME")%>");	
						return;
					}
				
					//End Addition By PradipK 15 Feb 2006
					if(flag==false)
					{
						objform.action = "IB_QueryBuilder.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_APPLY%>&Alphabet=<%=m_strAlphabet%>&QueryID=<%=m_lngQueryID%>"; 
						objform.submit(); 
					} 					
				}
			}
			function Back_OnClick()
			{
				objform.action = "IB_QueryBuilder.aspx?Mode=<%=CONST_QUERY_WIZ%>&Alphabet=<%=m_strAlphabet%>"; 
				objform.submit();  
			}
			function AddNew_OnClick()
			{
				objform.action = "IB_QueryBuilder.aspx?Mode=<%=CONST_QUERY_DETAILS%>&Alphabet=<%=m_strAlphabet%>&QueryID="; 
				objform.submit();
			}
	    function QuerySave_OnClick()
	    {
	        //Added by Nilesh g on 14/1/2016 for add loader on save link
	        var Mode = (arguments.length > 0) ? arguments[0] : "0";
	        if (Mode == "0") {	           
	           document.body.readonly=true;
	            window.setTimeout('QuerySave_OnClick("1")', 1);
	        }
	        if (Mode == "1") {
	       //endded by Nilesh g on 14/1/2016 for add loader on save link
	                var objTxt,flag;
	                var strValue,cnt;
	                var strquery,intPos,strCheckQuery;
	                var ret=false;
				
	                objTxt = GetObjectReference('frmQueryBuilder','txtQueryName');
	                flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_QUERY_NAME_EMPTY")%>',true);
	                if(flag==true)
	                {
	                    
	                    return;
	                }
	                flag = disallowSpecialCharacters(objTxt,'<%=MyBase.GetResourceString("MSG_QUERY_NAME_SPECIAL_CHAR")%>',true);	
	                if(flag==true)
	                {
	                  
	                    return;
	                }
				
	                strValue = objTxt.value;
	                for(cnt=0;cnt<intLength;cnt++)
	                {
	                    if(strValue == arrNames[cnt])
	                    {
	                        alert('<%=MyBase.GetResourceString("MSG_QUERY_NAME_DUPLICATE")%>');
	                    
	                        objTxt.focus();
	                        flag=true;
	                    }							
	                }
	                if(flag==true)
	                {
	                  
	                    return;
	                }
				
	                objTxt = GetObjectReference('frmQueryBuilder','txtQueryText');
	                flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_QUERY_TEXT_EMPTY")%>',true);
	                if(flag==false)
	                {				
	                    //check for comment(--) and "'" in the text, if present then dont save.
	                    strValue = objTxt.value;
												
	                    strquery = new String(strValue);
	                    while(strquery.indexOf('--') != -1)
	                    {
	                        var retVal;
	                        retVal=0;
						
	                        intPos = strquery.indexOf('--');
	                        strCheckQuery = strquery.substring(0,intPos+2);
	                        strquery = strquery.substring(intPos+2);
						
	                        retVal = CheckComment(strCheckQuery);
						
	                        if(retVal==1)
	                        {
	                            flag=true;
	                            alert('<%=MyBase.GetResourceString("MSG_COMMENT")%>');	
	                           
	                            return;		
	                        }
	                        else if(retVal==2)
	                        {
	                            intPos = strquery.indexOf("'");				
	                            strquery = strquery.substring(intPos + 1);
	                        }
	                        else
	                            return;						
	                    }										
	                    //Code Added By PradipK 15 Feb 2006
								
	                    if( formatQuery(strValue,'COMPLEXITY') == true)
	                    {						
	                        //End Addition By PradipK 15 Feb 2006
					
	                        if( formatQuery(strValue,'PRIORITY') == true)
	                        {
	                            if( formatQuery(strValue,'SEVERITY') == true)
	                            {	
	                                if( formatQuery(strValue,'STATUS') == true)
	                                {
	                                    flag=false;
	                                }
	                                else
	                                {
	                                    flag=true;
	                                    alert("'CORPORATESTATUS' " + "<%=MyBase.GetResourceString("MSG_CORPORATE_FIELD_NAME")%>");	
	                               
	                                    return;
	                                }
	                            }
	                            else
	                            {
	                                flag=true;
	                                alert("'CORPORATESEVERITY' " + "<%=MyBase.GetResourceString("MSG_CORPORATE_FIELD_NAME")%>");	
	                            
	                                return;
	                            }
	                        }
	                        else
	                        {
	                            flag=true;
	                            alert("'CORPORATEPRIORITY' " + "<%=MyBase.GetResourceString("MSG_CORPORATE_FIELD_NAME")%>");	
	                          
	                            return;
	                        }
	                        //Code Added By PradipK 15 Feb 2006				
	                    }
	                    else
	                    {
	                        flag=true;
	                        alert("'CORPORATECOMPLEXITY' " + "<%=MyBase.GetResourceString("MSG_CORPORATE_FIELD_NAME")%>");	
	                      
	                        return;
	                    }
				
	                    //End Addition By PradipK 15 Feb 2006
							
	                    if(flag==false)
	                    {
	                        setFrameLoader();//added by Nilesh on 8/1/2015 for loader add on save link
	                        objform.action = "IB_QueryBuilder.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&Alphabet=<%=m_strAlphabet%>&QueryID=<%=m_lngQueryID%>"; 
	                        objform.submit();
	                       // RemoveFrameLoader();//added by Nilesh on 8/1/2015 for loader add on save link
	                    } 
	                   
	                }						
	            }
	    }
			
			function Field_OnChange()
			{
			    	
				var objCbo;
				var strField;
				//Modified by SantoshK on Date June 7, 2006 for PMLifeLine Issue ID.4168
				//Purpose : Firefox Support				
				//COMMENTED BY nILESH G ON 12/2/2016
			    //var strBrowser = navigator.appName;	
				//Modification Ends by SantoshK on June 7, 2006
				try
				{
				/***********************************************************************************************/
				//Added By SandeepA on 5 Dec,2005 for Editable Date Control Issue (SP4)
				 intEditableDateControl= <%=m_intEditableDateControl%>;
				 //alert(intEditableDateControl);
				 if(intEditableDateControl==1)
				 {
					//Modified by SantoshK on Date June 7, 2006 for PMLifeLine Issue ID.4168
					//Purpose : Firefox Support
				     //COMMENTED BY nILESH G ON 12/2/2016
				     //if (strBrowser.indexOf("Internet") > 0)
					//{
						objFFE29587WHIZ_txtDueDate = GetObjectReference('frmTaskDetails','FFE29587WHIZ_txtDueDate');
						objFFE29587WHIZ_txtDueDate.style.display='none'; 
						objFFE29587WHIZ_txtDueDate.value='';
					
						objFFE29587WHIZ_txtReportedDate = GetObjectReference('frmTaskDetails','FFE29587WHIZ_txtReportedDate');
						objFFE29587WHIZ_txtReportedDate.style.display='none'; 
						objFFE29587WHIZ_txtReportedDate.value='';
					
						objFFE29587WHIZ_txtCreatedDate = GetObjectReference('frmTaskDetails','FFE29587WHIZ_txtCreatedDate');
						objFFE29587WHIZ_txtCreatedDate.style.display='none'; 
						objFFE29587WHIZ_txtCreatedDate.value='';
					
						objFFE29587WHIZ_txtClosedDate= GetObjectReference('frmTaskDetails','FFE29587WHIZ_txtClosedDate');
						objFFE29587WHIZ_txtClosedDate.style.display='none'; 
						objFFE29587WHIZ_txtClosedDate.value='';
					//}
					//Modification Ends by SantoshK on June 7, 2006
				 }
				//End of Addition by SandeepA on 5 Dec,2005 fro Editable Date Control Issue (SP4).
				/***********************************************************************************************/
				
					objCbo =  GetObjectReference('frmQueryBuilder','cboField');
					strField = new String(objCbo.value);
					objValue.value='';
					objValue.style.display='none';
					objCalendar.style.display='none';
					objValue=null;
					//alert(strField.toUpperCase());
					
					if(GetObjectReference('frmQueryBuilder','txtValue'))
					GetObjectReference('frmQueryBuilder','txtValue').style.display='none'; 
					
					if(strField.toUpperCase()=="ASSIGNTONAME")
						objValue = GetObjectReference('frmQueryBuilder','cboAssignTo');
					else if(strField.toUpperCase()=='CODEDBYNAME')
						objValue = GetObjectReference('frmQueryBuilder','cboCodedBy');
					else if(strField.toUpperCase()=='CODEDBYNAME')
						objValue = GetObjectReference('frmQueryBuilder','cboCodedBy');
					else if(strField.toUpperCase()=='CORRECTEDINVERSION')
						objValue = GetObjectReference('frmQueryBuilder','cboCorrectedInVersion');
					else if(strField.toUpperCase()=='REPORTEDINVERSION')
						objValue = GetObjectReference('frmQueryBuilder','cboReportedInVersion');
					else if(strField.toUpperCase()=='PHASE')
						objValue = GetObjectReference('frmQueryBuilder','cboPhase');
					else if(strField.toUpperCase()=='FOUNDINPHASE')
						objValue = GetObjectReference('frmQueryBuilder','cboFoundInPhase');
					else if(strField.toUpperCase()=='FIXEDINPHASE')
						objValue = GetObjectReference('frmQueryBuilder','cboFixedInPhase');
					else if(strField.toUpperCase()=='HARDWARE')
						objValue = GetObjectReference('frmQueryBuilder','cboHardware');
					else if(strField.toUpperCase()=='KERNEL')
						objValue = GetObjectReference('frmQueryBuilder','cboKernels');
					else if(strField.toUpperCase()=='MODULENAME')
						objValue = GetObjectReference('frmQueryBuilder','cboModuleName');
					else if(strField.toUpperCase()=='OS')
						objValue = GetObjectReference('frmQueryBuilder','cboOs');
					else if(strField.toUpperCase()=='PRIORITY')
						objValue = GetObjectReference('frmQueryBuilder','cboPriority');
					else if(strField.toUpperCase()=='SEVERITY')
						objValue = GetObjectReference('frmQueryBuilder','cboSeverity');
			
					//Code Added By PradipK on 15 Feb 2006
					else if(strField.toUpperCase()=='COMPLEXITY')
						objValue = GetObjectReference('frmQueryBuilder','cboComplexity');
						//End Addition By PradipK on 15 Feb 2006
						
					else if(strField.toUpperCase()=='STATUS')
						objValue = GetObjectReference('frmQueryBuilder','cboStatus');
					else if(strField.toUpperCase()=='SUBTYPE')
						objValue = GetObjectReference('frmQueryBuilder','cboSubtype');
					else if(strField.toUpperCase()=='TYPE')
						objValue = GetObjectReference('frmQueryBuilder','cboType');
					else if(strField.toUpperCase()=='CUSTOMERISSUEID')
						objValue = GetObjectReference('frmQueryBuilder','txtCustomerIssueID');
					else if(strField.toUpperCase()=='DESCRIPTION')
						objValue = GetObjectReference('frmQueryBuilder','txtDescription');
					else if(strField.toUpperCase()=='IMPORTID')
						objValue = GetObjectReference('frmQueryBuilder','txtImportID');
					else if(strField.toUpperCase()=='ISSUEID')
						objValue = GetObjectReference('frmQueryBuilder','txtIsuueID');
					else if(strField.toUpperCase()=='CHANGEREQUESTNAME')
						objValue = GetObjectReference('frmQueryBuilder','txtChangeRequestID');
					else if(strField.toUpperCase()=='KEYWORDS')
						objValue = GetObjectReference('frmQueryBuilder','cboKeywords');
					else if(strField.toUpperCase()=='SUMMARY')
						objValue = GetObjectReference('frmQueryBuilder','txtSummary');
					else if(strField.toUpperCase()=='DUEDATE')
					{
						objValue = GetObjectReference('frmQueryBuilder','txtDueDate');
						objCalendar = GetObjectReference('frmQueryBuilder','imgCalendar');
					}
					else if(strField.toUpperCase()=='CLOSEDDATE')
					{
						objValue = GetObjectReference('frmQueryBuilder','txtClosedDate');
						objCalendar = GetObjectReference('frmQueryBuilder','imgCalendar');
					}
					else if(strField.toUpperCase()=='REPORTEDDATE')
					{
						objValue = GetObjectReference('frmQueryBuilder','txtReportedDate');
						objCalendar = GetObjectReference('frmQueryBuilder','imgCalendar');
					}
					else if(strField.toUpperCase()=='CREATEDDATE')
					{
						objValue = GetObjectReference('frmQueryBuilder','txtCreatedDate');
						objCalendar = GetObjectReference('frmQueryBuilder','imgCalendar');
					}
					else if(strField.toUpperCase()=='SHOWTOCUSTOMER')
						objValue = GetObjectReference('frmQueryBuilder','cboShowToCustomer');
					else if(strField.toUpperCase()=='REPORTEDBY')
						objValue = GetObjectReference('frmQueryBuilder','cboReportedBy');
					else if(strField.toUpperCase()=='PROJECTNAME')
						objValue = GetObjectReference('frmQueryBuilder','cboProject');
					/*				 '****Code Added*******
					'By     :   DipaliS
					'Reason :   Reported Time Feature
					'Date   :   2 July 2004
					'Requirement Number :   IB_PBN_ENT_04
					'Addition Made  :   Added code to make the reported time text box visible .
					'	*/
							
					else if(strField.toUpperCase()=='REPORTEDTIME')
						objValue = GetObjectReference('frmQueryBuilder','txtReportedTime');
					/**********End Addition************/
					/*
						Added By SachinR	on 19 Jul 2004
						Issue - 12018
						Purpose	To plot combobox for rootcause and servicerequest fields
					*/
					else if(strField.toUpperCase()=='ROOTCAUSE')
						objValue = GetObjectReference('frmQueryBuilder','cboRootCause');
					//addition end
					
					/*				 '****Code Added*******
					'By     :   DipaliS
					'Reason :  Deliverable Feature
					'Date   :   18 July 2004
					'Addition Made  :   Added code to make the Deliverable Combo box visible .
					'	*/
							
					else if(strField.toUpperCase()=='DELIVERABLE')
						objValue = GetObjectReference('frmQueryBuilder','cboDeliverable');
					/**********End Addition************/
					//Integrated by PrashantD on 5 March 2007 for Product Execution Project
					/* Added By NitinVS on 27 MAy 06 for Roamware Customization */
					else if (strField.toUpperCase()=='PRODUCTVERSION')
						objValue = GetObjectReference('frmQueryBuilder','cboProductVersionID');
					else if (strField.toUpperCase()=='COMPONENT')
						objValue = GetObjectReference('frmQueryBuilder','cboComponentID');
					else if (strField.toUpperCase()=='CUSTOMER')
						objValue = GetObjectReference('frmQueryBuilder','cboCustomer');	
					/* End Addition By NitinVS on 27 MAy 06 for Roamware Customization */
					//End of integration by PrashantD on 5 March 2007 for Product Execution Project
					else
					{
						//custom field
						var strFld,strControlName;
						strFld = new String(strField.toUpperCase());
						
						if(strFld.indexOf('CUSTOMFIELD') >= 0)
						{
							strControlName = strField;
							
							if(strField.indexOf('+') >=0)
								strControlName = strField.substr(0,strField.indexOf('+'));
							
							if(strField.indexOf(' ') >=0)
								strControlName = strField.substr(0,strField.indexOf(' '));
								
							//alert(strControlName);	
							objValue = GetObjectReference('frmQueryBuilder',strControlName);

						/**********************************************************************************/
						//Added By SandeepA on 5 Dec,2005 for Editable Date Control Issue	
						if(intEditableDateControl==1)
					  {
					  //integrated by harshada d for PMLifeLine SP7 on 18 th july 2006
					  //objFFE29587WHIZ_txtCustomFieldDate = GetObjectReference('frmTaskDetails','FFE29587WHIZ_' + strControlName);
					  
					  //Code commented and added by PrashantD on 12 March 2007 for IssueID 11391
					  //objFFE29587WHIZ_txtCustomFieldDate = GetObjectReference('frmQueryBuilder', strControlName);
					  
					  if(objFFE29587WHIZ_txtCustomFieldDate)
					  		objFFE29587WHIZ_txtCustomFieldDate.style.display='none'; 
					
					   if(GetObjectReference('frmQueryBuilder', 'FFE29587WHIZ_'+strControlName))
					   		objFFE29587WHIZ_txtCustomFieldDate = GetObjectReference('frmQueryBuilder', 'FFE29587WHIZ_'+strControlName);
						else
							objFFE29587WHIZ_txtCustomFieldDate = GetObjectReference('frmQueryBuilder', strControlName);
						
						//objFFE29587WHIZ_txtCustomFieldDate.style.display='none'; 
						
						GetObjectReference('frmQueryBuilder', strControlName).value='';
					 //End of addition by PrashantD on 12 March 2007
						objFFE29587WHIZ_txtCustomFieldDate.value='';
					  }
						//End of Addition By SandeepA on 5 Dec,2005 for Editable Date Control ISsue.
						/**********************************************************************************/
															
						}
						else
							objValue = GetObjectReference('frmQueryBuilder','txtValue');
					}								
					
					//display the control	
					objValue.style.display = '';
					//alert(objValue.id);
					//populate the TD with control
					var objTD;
					objTD = GetObjectReference('frmQueryBuilder','TDFieldValue');
					//objTD.innerHTML="";
					objTD.appendChild(objValue);
					
										
					//if date control then display the calender link.
					
					// integrated by harshada d on 260920005 for whiz sem SP4 issue id 422
					//Modified By PrajaktaR on 8 July 2005 for SRIT IssueID 19899
					//if((strField.toUpperCase() == 'CREATEDDATE') || (strField.toUpperCase() == 'DUEDATE') || (strField.toUpperCase() == 'CLOSEDDATE') || (strField.toUpperCase() == 'REPORTEDDATE') || (strField.toUpperCase() == 'CUSTOMFIELDDATE'))
					
					if((strField.toUpperCase() == 'CREATEDDATE') || (strField.toUpperCase() == 'DUEDATE') || (strField.toUpperCase() == 'CLOSEDDATE') || (strField.toUpperCase() == 'REPORTEDDATE') || (strField.toUpperCase().substr(0,15) == 'CUSTOMFIELDDATE'))
					//End Of Modification By PrajaktaR on 8 July 2005 for SRIT IssueID 19899
					// end of integration by harshada d on 260920005 for whiz sem SP4 issue id 422								
					
					{
						/**********************************************************************************/
						//Added By SandeepA on 5 Dec,2005 For Editable Date Control Issue (SP4)
						if(intEditableDateControl==1)
					    {
							//Modified by SantoshK on Date June 7, 2006 for PMLifeLine Issue ID.4168
							//Purpose : Firefox Support
						    //COMMENTED BY nILESH G ON 12/2/2016
						    //if (strBrowser.indexOf("Internet") > 0)
							//{
					    		if ( (strField.toUpperCase() == 'CREATEDDATE') )
								{	
									/* Display Control */
									if(intCounter!=0)
									strCustomField.style.display='none';
							   		objTD.appendChild(objFFE29587WHIZ_txtCreatedDate);
									objFFE29587WHIZ_txtCreatedDate.style.display='';
								}	

					    		if ( (strField.toUpperCase() == 'DUEDATE') )
								{	
									/* Display Control */
									if(intCounter!=0)
									strCustomField.style.display='none';
									objTD.appendChild(objFFE29587WHIZ_txtDueDate);
									objFFE29587WHIZ_txtDueDate.style.display='';
								}	
								
					    		if ( (strField.toUpperCase() == 'CLOSEDDATE') )
								{	
							   		/* Display Control */
							   		if(intCounter!=0)
									strCustomField.style.display='none';
									objTD.appendChild(objFFE29587WHIZ_txtClosedDate);
									objFFE29587WHIZ_txtClosedDate.style.display='';
								}	
								
					    		if ( (strField.toUpperCase() == 'REPORTEDDATE') )
								{	
									/* Display Control */
									if(intCounter!=0)
									strCustomField.style.display='none';
									objTD.appendChild(objFFE29587WHIZ_txtReportedDate);
									objFFE29587WHIZ_txtReportedDate.style.display='';
								}	

								if ( (strField.toUpperCase().substr(0,15)  == 'CUSTOMFIELDDATE') )
								{	
																
									objFFE29587WHIZ_txtClosedDate.style.display='none';
									objFFE29587WHIZ_txtDueDate.style.display='none';
									objFFE29587WHIZ_txtCreatedDate.style.display='none';
									objFFE29587WHIZ_txtReportedDate.style.display='none';
									objFFE29587WHIZ_txtCustomFieldDate.style.display='none';
									if(intCounter!=0)
									strCustomField.style.display='none';
									/* Display Control */
							   		objTD.appendChild(objFFE29587WHIZ_txtCustomFieldDate);
									objFFE29587WHIZ_txtCustomFieldDate.style.display='';
									strCustomField=objFFE29587WHIZ_txtCustomFieldDate;
									intCounter+=1;
								}
							//}
							//Modification Ends by SantoshK on June 7, 2006
						 }	
						//End of Addition by SandeepA on 5 Dec,2005 for Editable Date Control Issue(SP4)
						/**********************************************************************************/
						//objTD.innerHTML += "<A Href='javascript:Calender_OnClick()'><Image id='imgCalendar' BORDER=0 src='../../Images/calendar.gif' alt='Click to open calendar' ></A>";							
						objCalendar.style.display='';
						objTD.appendChild(objCalendar);
					}
					//Added By SandeepA on 5 Dec,2005 for Editable Date Control Issue (SP4)
					else
					{
						//Clear all the Date controls 
						if(intEditableDateControl==1)
						{
							//Modified by SantoshK on Date June 7, 2006 for PMLifeLine Issue ID.4168
							//Purpose : Firefox Support
						    //COMMENTED BY nILESH G ON 12/2/2016
						    //if (strBrowser.indexOf("Internet") > 0)
							//{
								objFFE29587WHIZ_txtClosedDate.style.display='none';
								objFFE29587WHIZ_txtDueDate.style.display='none';
								objFFE29587WHIZ_txtCreatedDate.style.display='none';
								objFFE29587WHIZ_txtReportedDate.style.display='none';
								//objFFE29587WHIZ_txtCustomFieldDate.style.display='none';
							//}
							//Modification Ends by SantoshK on June 7, 2006
						}	
					}
					//End of Addition by SandeepA on 5 Dec,2005 for Editable Dat Control Issue (SP4)
				}
				catch(e)
				{ //do nothing 
				alert(e);
				}				
			}					
			
			function Calender_OnClick()
			{	
				var strControlID;
				strControlID = new String(objValue.id);
				//alert(strControlID);
				callcalendar('frmQueryBuilder',strControlID);
			}
			function Append_OnClick()
			{
				var strValue,flag=false;
				var objField,objOp;
				var strField,strOp,strCondition;
				
				objField = GetObjectReference('frmQueryBuilder','cboField');
				flag = disallowBlank(objField,'<%=MyBase.GetResourceString("MSG_FIELD_EMPTY")%>',true);
				if(flag==true)
					return;
				
				strField = new String(objField.value);
				
				objOp = GetObjectReference('frmQueryBuilder','cboOperator');
				flag = disallowBlank(objOp,'<%=MyBase.GetResourceString("MSG_OPERATOR_EMPTY")%>',true);
				if(flag==true)
					return;
				
				strOp = new String(objOp.value);
				
				//here reference of value field is taken again as it gives the value blank if 
				//we dont take the reference here.
				objValue = GetObjectReference('frmQueryBuilder',objValue.id);
				flag = disallowBlank(objValue,'<%=MyBase.GetResourceString("MSG_VALUE_EMPTY")%>',true);
				if(flag==true)
					return;
				
				strValue = new String(objValue.value);
				
				if(strField.toUpperCase()=='ISSUEID' || strField.toUpperCase()=='DURATION')
				{					
					flag = disallowNonNumeric(objValue,'<%=MyBase.GetResourceString("MSG_INVALID_VALUE")%>',true);
					if(flag==true)
						return;
					flag = disallowNegativeNumeric(objValue,'<%=MyBase.GetResourceString("MSG_INVALID_VALUE")%>',true);
					if(flag==true)
						return;					
				}
				else if(strField.toUpperCase()=='KEYWORDS')
				{
					if(strOp != 'LIKE' && strOp != 'NOT LIKE')
					{
						alert('<%=MyBase.GetResourceString("MSG_KEWORDS_OPERATOR")%>');
						objOp.focus();
						flag=true;
						return;
					}					
				}
				else if(strField.toUpperCase()=='DESCRIPTION')
				{
					if(strOp != 'LIKE' && strOp != 'NOT LIKE')
					{
						alert('<%=MyBase.GetResourceString("MSG_DESCRIPTION_OPERATOR")%>');
						objOp.focus();
						flag=true;
						return;
					}					
				}
				/*				 '****Code Added*******
					'By     :   DipaliS
					'Reason :   Reported Time Feature
					'Date   :   2 July 2004
					'Requirement Number :   IB_PBN_ENT_04
					'Addition Made  :   Added code to make the reported time text box visible .
					'	*/
				else if(strField.toUpperCase()=='REPORTEDTIME')
				{
					if(isTime(objValue,"<%=mybase.GetResourceString("MSG_INVALIDTIME",false)%>")==false)
						flag = true;
					else
						flag=false;
					if(flag==true)
						{
						//Added By DipaliS 7 July to resolve issue 11805
						return;
						}
					
				}	
				/***********End Addition************/

				//append the values, for LIKE and NOT LIKE operator append % before and after value
				if(strOp=='LIKE' || strOp=='NOT LIKE')
					strValue = '%' + strValue + '%';
					
				//strField = strField.replace('+',' ');
								
				if(flag==false)
				{
					strCondition = strField + ' ' + strOp + ' ';
					strValue = strValue.replace('+',' ');
					//Modified by PrashantD on for Product Execution 
					//strValue = strValue.replace("'","''");
					strValue = strValue.replace(/'/g,"''");
					//End of modification by PrashantD 
					 	
					if(strField.toUpperCase() == 'ISSUEID' || strField.toUpperCase() == 'SHOWTOCUSTOMER' || strField.toUpperCase() == 'DURATION')
					{
						strValue = strValue.replace("'"," ") 
						strCondition += strValue;
					}
					else
						strCondition += "'" + strValue + "'";					 
						
					var objText;
					objText = GetObjectReference('frmQueryBuilder','txtQueryText');
					//objText.innerHTML += ' ' + strCondition;
					//Modified by SantoshK on Date June 7, 2006 for PMLifeLine Issue ID.4168
					//Purpose : Firefox Support
					objText.value += ' ' + strCondition;
					//Modification Ends by SantoshK on June 7, 2006
				}
				
			}
			function Bracket_OnClick(strBkt)
			{
				var objText;
				objText = GetObjectReference('frmQueryBuilder','txtQueryText');
				//Modified by SantoshK on Date June 7, 2006 for PMLifeLine Issue ID.4168
				//Purpose : Firefox Support
				//objText.innerHTML += ' ' + strBkt + ' ';
				objText.value += ' ' + strBkt + ' ';
				//Modification Ends by SantoshK on June 7, 2006
			}
			function Operator_OnClick(strOp)
			{
				var objText;
				objText = GetObjectReference('frmQueryBuilder','txtQueryText');
				//Modified by SantoshK on Date June 7, 2006 for PMLifeLine Issue ID.4168
				//Purpose : Firefox Support
				//objText.innerHTML += ' ' + strOp + ' ';
				objText.value += ' ' + strOp + ' ';
				//Modification Ends by SantoshK on June 7, 2006
			}
        //Added by Dhanashri S on 30 Nov 2015
			function ClearAll_OnClick()
			{
				var objText;
				objText = GetObjectReference('frmQueryBuilder','txtQueryText');
				//Modified by SantoshK on Date June 7, 2006 for PMLifeLine Issue ID.4168
				//Purpose : Firefox Support				
			    //objText.innerHTML = '';
                if(objText!=null)
			        objText.value = '';
                //Modified by swapnil aswale on 12-07-2015
			    var objChk,objTxt;
			    var intCnt,i;
				
			    objTxt = GetObjectReference('frmQueryBuilder','hdtxtRowCount');
			    if (objTxt != null)
			    intCnt = objTxt.value;
				
			    objChk = GetObjectReference('frmQueryBuilder','chkDelete',true);
			    
			    for(i=0;i<intCnt;i++)
			        if(objChk[i].disabled==false)
			        {
			          
			            objChk[i].checked = false;		
			        }
                //Ended

				//Modification Ends by SantoshK on June 7, 2006
			}
        //End of Addition by Dhanashri S on 30 Nov 2015
			/*function CheckComment(strCheckQuery)
			{
				var intFirstPos,ret,strQuery,val;
				ret=0;
				intFirstPos = strCheckQuery.indexOf('--');
				
				if(intFirstPos > 0)
				{
					strQuery = strCheckQuery.substring(0,intFirstPos-1);
					
					val = Occurence(strQuery,"'",0);
					
					if(val == 1)
						ret=2;	//no problem
					else
						ret=1;	//problem
				}
			
				return ret;				
			}
			function Occurence(strValue,strSearch,intStart)
			{
				var intCnt,intStart;
				var strQ;
				intCnt=0;
				
				strQ = new String(strValue);
				if(strQ.indexOf(strSearch) != -1)
				{					
					while(strQ.indexOf(strSearch,intStart) != -1) 
					{
						intStart = strQ.indexOf(strSearch,intStart)+1;
						intCnt += 1;							  
					}
					intCnt = intCnt % 2;	
				}
				
				return intCnt;				
			}*/
			function formatQuery(strQuery,strFieldName)
			{
				var intStart,strQ1,strField;
				var objTxt;
				var ret=true;
				var strQ2;
				
				strField = new String(strFieldName);
				strQ1 = new String(strQuery);
				strQ1 = strQ1.toUpperCase();
				
				if(strQ1.indexOf(strFieldName,intStart) != -1)
				{
					while(strQ1.indexOf(strFieldName,intStart) != -1)
					{
						var val;
						
						intStart = strQ1.indexOf(strFieldName,intStart);
						strQ2 = strQ1.substr(0,intStart-1);
						
						if(strQ2 != '')
						{
							//check whether fieldName is specified inthe single quotes
							if( Occurence(strQ2,"'",1) == 0)
								if(intStart >= 9)
									if(strQ1.substr(intStart-9,9) == 'CORPORATE')
										ret=false;							
						}
						else
						{
							if(intStart >= 9)
								if(strQ1.substr(intStart-9,9) == 'CORPORATE')
									ret=false;							
						}
						intStart += strField.length;							 
					}			
					objTxt = GetObjectReference('frmQueryBuilder','txtQueryText');
					objTxt.value = strQ1;		
				}
				
				return ret;
			}
			
			function SelectAll_OnClick()
			{
				var objChk,objTxt;
				var intCnt,i;
				
				objTxt = GetObjectReference('frmQueryBuilder','hdtxtRowCount');
				intCnt = objTxt.value;
				
				objChk = GetObjectReference('frmQueryBuilder','chkDelete',true);
				for(i=0;i<intCnt;i++)
					if(objChk[i].disabled==false)
						objChk[i].checked = true;						
			}
			
    
		</script>
	</body>
<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>


<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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