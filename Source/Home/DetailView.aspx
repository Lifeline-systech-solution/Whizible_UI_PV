<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DetailView.aspx.vb" Inherits="PbNIT.DetailView" %>
<%--Added by Dhanashri S on 1 Aug 2016--%>
<!DOCTYPE HTML>
<%--End of Addition by Dhanashri S on 1 Aug 2016--%>
<HTML>

    <%--Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
<%--<script src="../../responsive/jquery/jquery-2.1.3.min.js"></script>--%> 
<%--<script src="../../responsive/jquery/jquery-3.5.1.min.js"></script>--%>

 <%--   Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade
  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>

    <%CommonFunctions.General.PlotPageHeadTag("Detail View")%>
	<style>
		tr.clsTRPageCaption{background:#e7edf0}
tr.clsTRPageCaption td{padding:10px}
div#PageDiv{background:#fff}
TABLE.clsTable{background:#fff}
table#tblCap02182{margin:0 10px;width:98%}
table#tblCap02182 tr td{color:#4263c1;font-size:14px}
#tblCap02182 + br + table tbody tr td[width='50%']>table{position:relative;top:62px}
.clsTable #trItem_Manage td{vertical-align:top}
.clsTable #trItem_Manage td a{text-decoration:none;color:#464a4c;font-weight:700;display:block}
.clsTable #trItem_Manage td a:hover{color:#135a9c}
#trItem_Manage td[colspan='3'] font{font-weight:700;color:#464a4c}
#tblCap02182 + br + table.clsTable{margin:0 10px;border:1px solid #ddd;width:98%;padding:5px;background:#fff;min-height:50vh;border-radius:4px}
#trItem_Manage td hr{border:none}
.clsTable #trItem_Manage td a:hover img{border:none!important;width:30px}
#tblCap02182 + br + table tbody tr td[width='50%']>table>tbody>tr>td{padding:5px 0 10px}
table{color:#464a4c}
.clsTable td{vertical-align:top}
		</style>
    <body MS_POSITIONING="clsFullPageBody" class="clsPrintBody" onresize="window_onresize()" onload="window_onload()">
    <form name="frmDetailView" id="frmDetailView" method="post" runat="server">
		<%PageInit()%>
    <div id="fillDiv" style="filter: alpha(opacity=60);background-color:#d1d1d1;DISPLAY: none; Z-INDEX: 100; LEFT: 0px; VISIBILITY: visible; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%"></div>    
    
    <div id="pleasewaitscreen" style="position:absolute;z-index:105;top:30%;left:35%;display:none;">
 <table class="clsTable" border=1 cellpadding="0" cellspacing="0" height="200" width="300">
    <tr class="clsTREven">
  <td style="width:100%;height:100%;text-align:center" valign="middle">
   <br/><br/>   
            <b>Processing...  please wait...</b>
    <br/><br/>
  </td>
 </tr>
    </table>
</div>		

		</form>
		<script language="javascript" type="text/javascript">

		    var objForm, objDivMain;

		    objForm = GetFormReference('frmDetailView');
		    objDivMain = GetObjectReference('frmDetailView', 'PageDiv');


		    ////	
		    ////	if ("<%=m_intShowMarquee%>" != "0")
		    ////    {
		    ////        debugger;
		    ////        objMarqueeHome = parent.document.getElementById("MarqueeHome");
		    ////        objMarqueeHome.style.display = "none"; 
		    ////    } 

		    function window_onload() {

		        var intDivHeight;

		        if (objDivMain != null) {

		            if (navigator.appName == "Netscape") {
		                //commented by Shamkant S on 6 Nov 2015
		                //intDivHeight = window.innerHeight - objDivMain.offsetTop - 40;
		                intDivHeight = (window.innerHeight - objDivMain.offsetTop - 40) + 25;
		            }
		            else {
		                //commented by Shamkant S on 6 Nov 2015
		                // intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		                intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40 + 25;
		            }

		            if (intDivHeight < 100)
		                intDivHeight = 100;
		            objDivMain.style.height = intDivHeight + 'px';

		        }
		    }

		    function window_onresize() {
		        var intDivHeight;
		        if (objDivMain) {
		            intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 50;
		            if (intDivHeight < 100) intDivHeight = 100;
		            objDivMain.style.height = intDivHeight + 'px';
		        }
		    }

		    function OpenPage_Onclick(URL, height, width, ControlItemID, intTagID)
		    {
		      
		        var str = URL;
		        var res = str.split("=");
		        var CTReportID = res[1];
		        var Mode = (arguments.length > 5) ? arguments[5] : "0";

		        if (Mode == "0") {

		            objWait = GetObjectReference('frmDetailView', 'pleasewaitscreen');
		            objWait.style.display = "block";
		            document.getElementById('fillDiv').style.display = "block";
		            document.body.readonly = true;
		            window.setTimeout('OpenPage_Onclick("' + URL + '",' + height + ',' + width + ',' + ControlItemID + ',' + intTagID + ',"1")', 1)
		        }
		        if (Mode == "1") {
		            //Modified by swapnil aswale on 3rd Nov 2015
		            //Replace () to [] 
		            //Replace document.forms[0].parentElement.parentElement.ownerDocument.parentWindow to document.forms[0].parentElement.parentElement.ownerDocument.defaultView
		            //For Browser Compatibility 

		            if (document.forms[0].parentElement.parentElement.ownerDocument.defaultView.frames.length > 0) {

		                document.forms[0].parentElement.parentElement.ownerDocument.defaultView.frames.parent.frames[0].parent.document.all("hidDefaultTagID").value = intTagID;

		                if (ControlItemID != "" && ControlItemID != "0") {

		                    document.forms[0].parentElement.parentElement.ownerDocument.defaultView.frames.parent.frames[0].parent.document.all("imgFav").src = '../../Images/Home/favorites-.gif';
		                    document.forms[0].parentElement.parentElement.ownerDocument.defaultView.frames.parent.frames[0].parent.document.all("imgFav").title = 'Remove from favourites';
		                }
		                else {

		                    document.forms[0].parentElement.parentElement.ownerDocument.defaultView.frames.parent.frames[0].parent.document.all("imgFav").src = '../../Images/Home/favorites+.gif';
		                    document.forms[0].parentElement.parentElement.ownerDocument.defaultView.frames.parent.frames[0].parent.document.all("imgFav").title = 'Add to favourites';
		                }
		            }
		            //Ended
		            //Added By Vidya J ON 2 Feb 2016
		            $.ajax({
		                type: 'POST',
		                dataType: 'json',
		                contentType: 'application/json',
		                url: 'DetailView.aspx/GenrateURLToken_OpenPage_Onclick',
		                data: JSON.stringify({ CTReportID: CTReportID, MenuGroupID: '<%=m_intMenuGroupID%>', EmployeeID: "<%=Session("intUserID")%>" }),
	                    success: function (Result) {
	                      
	                        window.location.href = URL + "&From_Where=DETAILVIEW&MenuGroupID=<%=m_intMenuGroupID%>&PKToken=" + Result.d;
        },
        error: function () {
         //   alert("Error")
        }

	        });
                //End Of Added By Vidya J ON 2 Feb 2016  


    }
}

function Home_OnClick() {
    //window.location.href = "../Home/HRHome.aspx";
    //var LDAPAuthenticationMode;
    //LDAPAuthenticationMode="<%=CommonFunctions.General.GetApplicationKeySetting("AuthenticationType").ToString%>";
	    window.open("../General/Navigation.aspx?FromWhere=<%=m_strShortName%>", "_top")
	}

	function ShowGrid(Process) {
	    var strTRName = 'trItem_' + Process;
	    var strImgName = 'img_' + Process;
	    var ObjTr = GetObjectReference("frmDetailView", strTRName, true)
	    var objimageControl = GetObjectReference("frmDetailView", strImgName)
	    var replacementstyle;

	    //var objExpandedID = GetObjectReference("frmDetailView","ExpandedID");
	    //debugger;

	    if (ObjTr.length == 0)
	        return;


	    if (ObjTr[0].style.display == 'none') {
	        replacementstyle = '';
	        objimageControl.src = "../../Images/minus.gif"
	        //Added By KapilGK
	        /*if(objExpandedID.value=="")
                objExpandedID.value = "," + objExpandedID.value + Process + ",";
            else*/
	        //if ((objExpandedID.value).search(","+Process+",")==-1)
	        //    objExpandedID.value = objExpandedID.value + Process + ",";
	    }
	    if (ObjTr[0].style.display == '') {
	        replacementstyle = 'none';
	        objimageControl.src = "../../Images/plus.gif"
	        //Added By KapilGK
	        //objExpandedID.value = objExpandedID.value + Process + ",";
	        //objExpandedID.value = (objExpandedID.value).replace(","+Process+",", ",0,");
	    }
	    var i;
	    for (i = 0; i < ObjTr.length; i++) {
	        ObjTr[i].style.display = replacementstyle;
	    }
	}
	function Section_GridView(intMenuGroupID) {
	    window.open("../Home/ControlMenuGroup.aspx?MenuGroupID=" + intMenuGroupID, "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=900,height=600");

	   
	}
	function DesignMode_OnClick(intMode) {
	    objForm.action = '../Home/DetailView.aspx?IsDesignMode=' + intMode;
	    objForm.submit();
	}
	function Configure_Item(intControlItemID, intMenuGroupID) {
	    window.open("../General/CommonPage.aspx?ControlItemID_PK=" + +intControlItemID + "&SubTagFromCL=1&ForeignKey=MenuGroupID&ForeignKeyValue=" + intMenuGroupID + "&MasterTagID=3312&FromWhere=SM&SubTagPagingAlphabet=-1&ParentTagID=3952&SubTagSortBy=&STAccessFirstTime=0&SubTagSortOrder=&PagingNumber=1", "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=900,height=600");
	}

	//Added by SujitG on 05 Sep 2008 
	function LastUpdated(strURL) {
	    window.location.href = strURL;
	}
	//End of addition by SujitG on 05 Sep 2008 

	function addRemoveFavorites(intControlItemID, strMode) {
	    // A Add to Favourites
	    // D delete from Favourites
	    // R Remove all 

	    /*var objFavCount =GetObjectReference('frmDetailView','hid_favCount');
        
        if(objFavCount !=null)
        {
            if (strMode == 'A')
            {
                objFavCount.value = parseInt(objFavCount.value) + 1;
            }
            
            if (strMode == 'D')
            {
                objFavCount.value = parseInt(objFavCount.value) - 1;
            }
            if (strMode == 'R')
            {
                objFavCount.value = 0;
            }
        }*/
	    var objimgFav = GetObjectReference('', 'imgFav' + intControlItemID);
	    if (objimgFav != null) {
	        if (strMode == 'A') {
	            objimgFav.src = "../../Images/Home/RemoveFavorite.gif";
	            objimgFav.onclick = "addRemoveFavorites(" + intControlItemID + ",'D')";
	            objimgFav.title = "Remove from favourites";
	        }
	        else {
	            objimgFav.src = "../../Images/Home/AddFavorite.gif";
	            objimgFav.onclick = "addRemoveFavorites(" + intControlItemID + ",'A')";
	            objimgFav.title = "Add to favourites";
	        }
	    }
	    loadXMLDoc("DetailView.aspx?IsXMLHTTP=1", "Mode=" + strMode + "&ControlItemID=" + intControlItemID)
	    /*if (navigator.appName =='Netscape')
            {
                var url="DetailView.aspx?IsXMLHTTP=1&Mode="+strMode+"&ControlItemID="+intControlItemID;
                objXMLHTTP=new XMLHttpRequest();		
                objXMLHTTP.onreadystatechange=xmlhttpChange;
                objXMLHTTP.open("GET",url,true);
                objXMLHTTP.send(null);
            }
            else
            {
                var url="DetailView.aspx?IsXMLHTTP=1&Mode="+strMode+"&ControlItemID="+intControlItemID;
                objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
                objXMLHTTP.onreadystatechange=xmlhttpChange;
                objXMLHTTP.open("GET",url,false);
                objXMLHTTP.send();
            }*/

	}
	function loadXMLDoc(url, reqQuery) {
	    // code for Mozilla, etc.
	    if (window.XMLHttpRequest) {
	        xmlhttp = new XMLHttpRequest()
	        xmlhttp.onreadystatechange = xmlhttpChange;

	        if (ns) {
	            xmlhttp.open("GET", url + "&" + reqQuery, true)
	            xmlhttp.send(false)
	        }
	        else {
	            xmlhttp.open("POST", url, true)
	            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	            xmlhttp.send(reqQuery)
	        }
	    }
	        // code for IE
	    else if (window.ActiveXObject) {
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
	        if (xmlhttp) {
	            xmlhttp.onreadystatechange = xmlhttpChange
	            xmlhttp.open("POST", url, true)
	            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	            xmlhttp.send(reqQuery)
	        }
	    }
	}


	function xmlhttpChange() {
	    if (xmlhttp.readyState == 4) {
	        if (xmlhttp.status == 200) {
	            //alert(objXMLHTTP.responseText);
	            //alert('Item added to favourites');
	            //var objDivFav = GetObjectReference('frmDetailView','DivFav');

	            /*if (objDivFav != null)
                {
                    //alert(1);
                    objDivFav.innerHTML = objXMLHTTP.responseText;
                }*/

	        }
	    }
	}
	function Back_OnClick() {
	    window.location.href = "HRHome.aspx?Fromwhere=HOME";
	}

	</script>
</body>
</html>
