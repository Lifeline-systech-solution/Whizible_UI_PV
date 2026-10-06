<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_ReportDesigner.aspx.vb" Inherits="Whiz.CRW_ReportDesigner" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>

    <body class="clsBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
        <form id="frmDesigner" name="frmDesigner" method="post" runat="server">
            <%PageInit%>
        </form>
        
        <!-- Added By Puneet M ON 24-11-2015 -->
        <style type="text/css">
            #divReportHeader {
                display:block !important;
            }
            #divPageHeader  {
                display:block !important;
            }
            #divGroupHeader {
                display:block !important;
            }
            #divDetail      {
                display:block !important;
            }
            #divGroupFooter {
                display:block !important;
            }
            #divPageFooter  {
                display:block !important;
            }
            #divReportFooter{
                display:block !important;
            }
            #tblReportHeader {
                position:relative !important;
            }
            #tblPageHeader {
                position:relative !important;
            }
            #tblGroupHeader{
                position:relative !important;
            }
            #tblDetail{
                position:relative !important;
            }
            #tblGroupFooter{
                position:relative !important;
            }
            #divPageFooter{
                position:relative !important;
            }
            #divReportFooter{
                position:relative !important;
            }
        </style>
        <!-- Ended By Puneet M ON 24-11-2015 -->

        <script language="javascript">
	        var objdivlist;
	        var objfrm;
	        objfrm = GetFormReference('frmDesigner');
	        objdivlist = GetObjectReference('frmDesigner','divReportBody');
	        var strPKToken;
	        var objPKToken = GetObjectReference('frmDesigner','PKToken');
	        if (objPKToken){strPKToken = objPKToken.value;}
	        function SmartDesigner_OnClick(lngReportID)
	        {
		        window.open("CRW_SmartDesigner.aspx?ReportID=" + lngReportID,"","height=600,width=700,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-600)/2 + ",resizable=yes;scrollbars=no");
	        }
            function Release_OnClick(lngReportID)
            {
	            window.open("CRW_CopyReport.aspx?MasterTagID=<%=m_lngMasterTagID%>&Mode=<%=CONST_RELEASE_MODE%>&ReportID=" + lngReportID,"","height=230,width=550,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-230)/2 + ",resizable=no,scrollbars=no");  //Modified By : Ninad   Req Id : WAF3_PB_42 - Dropdown Menu, to adjust win height
            }
            function Back_OnClick(MasterTagID,FromWhere)
            {	
                window.location.href ="../CRW/CRW_CommonList.aspx?MasterTagID=" + MasterTagID + "&FromWhere=" + FromWhere;
            }
            function PreviewReport_OnClick(ReportID)
            {
                var strURL = "CRW_ReportUIBuilder.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + ReportID + "&FromWhere=Designer&PKToken=" + strPKToken;
                window.open(strURL,"","left=" + (window.screen.width-750)/2 + ",top=" + (window.screen.height-500)/2 + ",height=500,width=750,resizable=yes,scrollbar=no"); //WAF3_PB_42 April 20, 2007 NinadP
            }
            function ConfigureUI_OnClick(ReportID)
            {
                var strURL = "CRW_ReportUIConfiguration.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + ReportID + "&PKToken=" + strPKToken; 
                window.open(strURL,"","left=" + (window.screen.width-750)/2 + ",top=" + (window.screen.height-300)/2 + ",height=300,width=750,resizable=yes,scrollbar=yes");
            }
            function CopyReport_OnClick(lngReportID)
            {
                window.open("CRW_CopyReport.aspx?MasterTagID=<%=m_lngMasterTagID%>&Mode=<%=CONST_COPY_REPORT_MODE%>&ReportID=" + lngReportID,"","height=280,width=550,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-280)/2 + ",resizable=no,scrollbars=no");
            }
            function AddGroup_OnClick(lngReportID) 
            {
	            var strURL = "CRW_GroupConfiguration.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + lngReportID + "&Mode=Add&GroupingOrder=0";
	            window.open(strURL,"","left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-400)/2 + ",height=400,width=600,resizable=no,scrollbar=no");
            }	
	        function AddSubreport_OnClick(strSection,str,lngRID)
	        {
		        var objTxt,intCnt;
		        objTxt = GetObjectReference('frmDesigner','txtSubreportCount');
		        intCnt = objTxt.value;
        		
		        if(intCnt>=100)
		        {
			        alert('<%=MyBase.GetResourceString("MSG_SUBREPORT_LIMIT")%>');
			        return;
		        }
        		
		        if(strSection=='<%=MyBase.GetResourceString("REPORT_GROUP_HEADER")%>' || strSection=='<%=MyBase.GetResourceString("REPORT_GROUP_FOOTER")%>')
		        {
			        objTxt = GetObjectReference('frmDesigner','txtGroupCount');
			        intCnt=objTxt.value;
			        if(intCnt<=0)
			        {
				        alert('<%=MyBase.GetResourceString("MSG_NO_GROUP")%>');
				        return;
			        }
		        }
		        window.open("CRW_SubreportField.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + lngRID + "&Section=" + strSection,"","left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",height=500,width=700,resizable=no,scrollbar=no");
	        }
            function Subreport_OnClick(strSection,str,lngRDID,lngRID)
            {
	            //call page to add subreport in the detail section
	            window.open("CRW_SubreportField.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + lngRID + "&Section=" + strSection + "&ControlID=" + lngRDID,"","left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",height=500,width=700,resizable=no,scrollbar=no");
            }
            function SubreportPreview_OnClick(subreportID,strPKTokenForSubReport)
            {	//call the designer page for the subreport on which user has clicked
	            var strURL = "CRW_ReportDesigner.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + subreportID + "&Mode=None&PKToken=" + strPKTokenForSubReport;
	            window.open(strURL,"","left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-600)/2 + ",height=600,width=800,resizable=yes,scrollbar=no");	
            }	
            function ReportProperties_OnClick(lngReportID) 
            {
                var iHeight=650; var iWidth=820;
                <%If m_blnIsSubreport=True Then%>
                iHeight = 485;
                <%End If%>
	            window.open("CRW_ReportProperties.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + lngReportID,"","left=" + (window.screen.width-iWidth)/2 + ",top=" + (window.screen.height-iHeight)/2 + ",height="+iHeight+",width="+iWidth+",resizable=no,scrollbar=no"); 
            }	
            function AdvancedView_OnClick(lngReportID,strMasterTagID,strFromWhere) 
            {	//submit the form to open in advanced view
	            var strURL = "CRW_ReportDesigner.aspx?ReportID=" + lngReportID + "&Mode=AdvancedView&MasterTagID=" + strMasterTagID + "&FromWhere=" + strFromWhere + "&PKToken=" + strPKToken;
	            frmDesigner.action = strURL;
	            frmDesigner.submit();   
            }
            function DefaultView_OnClick(RID,MTagID,FW)
            {
	            var strURL = "CRW_ReportDesigner.aspx?ReportID=" + RID + "&Mode=None&MasterTagID=" + MTagID + "&FromWhere=" + FW + "&PKToken=" + strPKToken;
	            frmDesigner.action = strURL;
	            frmDesigner.submit();
            }	
            function GroupConfigure_OnClick(intGroupingOrder,intReportID)
            {
	            var strURL = "CRW_GroupConfiguration.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + intReportID + "&Mode=Edit&GroupingOrder=" + intGroupingOrder;
	            window.open(strURL,"","left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-400)/2 + ",height=400,width=600,resizable=no,scrollbar=no");
            }
            function OutputFormat_OnClick(RID,MTagID)
            {	var strURL = "../General/CommonList.aspx?FromWhere=CRW&MasterTagID=" + MTagID + "&ReportID=" + RID;
	            window.open(strURL,"","left=" + (window.screen.width-400)/2 + ",top=" + (window.screen.height-250)/2 + ",height=250,width=400,resizable=no,scrollbar=no");
            }
            function AddControl_OnClick(strSection,strControltype,ReportID)
            {
	            var strURL,objTxt,intCnt;
	            var str = new String(strControltype);            		 
	            if(strSection=='<%=MyBase.GetResourceString("REPORT_GROUP_HEADER")%>' || strSection=='<%=MyBase.GetResourceString("REPORT_GROUP_FOOTER")%>')
	            {
		            objTxt = GetObjectReference('frmDesigner','txtGroupCount');
		            intCnt=objTxt.value;
		            if(intCnt<=0)
		            {
			            alert('<%=MyBase.GetResourceString("MSG_NO_GROUP")%>');
			            return;
		            }
	            }            	
	            if(str.toUpperCase() =='LABEL') 
	            {	//call the label properties page
		            strURL = "CRW_ReportControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Label&ControlID=0&Mode=Add&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-670)/2 + ",top=" + (window.screen.height-420)/2 + ",height=420,width=670,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='LINE') 
	            {	//call the line properties page
		            strURL = "CRW_ReportControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Line&ControlID=0&Mode=Add&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-250)/2 + ",height=250,width=550,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='GRAPH') 
	            {	//call the graph properties page
		            strURL = "CRW_GraphControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Graph&ControlID=0&Mode=Add&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-670)/2 + ",top=" + (window.screen.height-560)/2 + ",height=560,width=670,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='FIELD') 
	            {	//call the field properties page
		            strURL = "CRW_ReportControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Field&ControlID=0&Mode=Add&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-555)/2 + ",height=555,width=800,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='SUBREPORT') 
	            {	//call the subreport properties page
		            var objTxt,intCnt;
		            objTxt = GetObjectReference('frmDesigner','txtSubreportCount');
		            intCnt = objTxt.value;            		
		            if(intCnt>=100)
		            {
			            alert('<%=MyBase.GetResourceString("MSG_SUBREPORT_LIMIT")%>');
			            return;
		            }            	
		            strURL = "CRW_SubreportProperties.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlID=0&Mode=Add&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-400)/2 + ",height=400,width=700,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='IMAGE') 
	            {	//call the image properties page
		            strURL = "CRW_ReportControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Image&ControlID=0&Mode=Add&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-650)/2 + ",top=" + (window.screen.height-300)/2 + ",height=300,width=650,resizable=no,scrollbar=no");
	            }
                else if(str.toUpperCase() =='DYNAMICDATAGRID') 
	                {	//call the subreport properties page
		                var objTxt,intCnt;
		                objTxt = GetObjectReference('frmDesigner','txtDynamicDataGridCount');
		                intCnt = objTxt.value;
                		
		                if(intCnt>=100)
		                {
			                alert('<%=MyBase.GetResourceString("MSG_SUBREPORT_LIMIT")%>');
			                return;
		                }
                	
		                strURL = "CRW_DynamicDataGridProperties.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlID=0&Mode=ADD&Section=" + strSection + "&ReportID=" + ReportID;
		                window.open(strURL,"","left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-500)/2 + ",height=450,width=800,resizable=no,scrollbar=no"); //WAF3_PB_42 April 17, 2007 NinadP
	                }
            }		
            function Control_OnClick(strSection,strControltype,controlID,ReportID)
            {
	            var strURL;
	            var str = new String(strControltype);
            	
	            if(str.toUpperCase() =='LABEL') 
	            {	//call the label properties page
		            strURL = "CRW_ReportControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Label&Mode=Edit&ControlID=" + controlID + "&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-670)/2 + ",top=" + (window.screen.height-400)/2 + ",height=400,width=670,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='LINE') 
	            {	//call the line properties page
		            strURL = "CRW_ReportControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Line&Mode=Edit&ControlID=" + controlID + "&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-250)/2 + ",height=250,width=550,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='GRAPH') 
	            {	//call the graph properties page
		            strURL = "CRW_GraphControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&Mode=Edit&ControlID=" + controlID + "&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-670)/2 + ",top=" + (window.screen.height-530)/2 + ",height=530,width=670,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='FIELD') 
	            {	//call the field properties page
		            strURL = "CRW_ReportControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Field&Mode=Edit&ControlID=" + controlID + "&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-525)/2 + ",height=525,width=800,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='SUBREPORT') 
	            {	//call the field properties page
		            strURL = "CRW_SubreportProperties.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlID=" + controlID + "&Mode=Edit&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-400)/2 + ",height=400,width=700,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='IMAGE') 
	            {	//call the field properties page
		            strURL = "CRW_ReportControl.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlType=Image&Mode=Edit&ControlID=" + controlID + "&Section=" + strSection + "&ReportID=" + ReportID;
		            window.open(strURL,"","left=" + (window.screen.width-650)/2 + ",top=" + (window.screen.height-280)/2 + ",height=280,width=650,resizable=no,scrollbar=no");
	            }
	            else if(str.toUpperCase() =='DYNAMICDATAGRID') 
	            {	//call the DynamicDataGrid properties page
		            strURL = "CRW_DynamicDataGridProperties.aspx?MasterTagID=<%=m_lngMasterTagID%>&ControlID=" + controlID + "&Mode=Edit&Section=" + strSection + "&ReportID=" + ReportID + "&SPorDDG=1";
		            window.open(strURL,"","left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-400)/2 + ",height=450,width=800,resizable=no,scrollbar=no"); //WAF3_PB_42 April 17, 2007 NinadP
	            }
            }	
            function AddDynamicDataGrid_OnClick(strSection,str,lngRID)
            {
	            var objTxt,intCnt;
	            objTxt = GetObjectReference('frmDesigner','txtDynamicDataGridCount');
	            intCnt = objTxt.value;            	
	            if(intCnt>=100)
	            {
		            alert('<%=MyBase.GetResourceString("MSG_SUBREPORT_LIMIT")%>');
		            return;
	            }
	            //call page to add DynamicDataGrid in the detail section
	            window.open("CRW_DynamicDataGridProperties.aspx?MODE=ADD&MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + lngRID + "&Section=" + strSection,"","left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-500)/2 + ",height=450,width=800,resizable=no,scrollbar=no"); //WAF3_PB_42 April 17, 2007 NinadP
            }	
            function DynamicDataGrid_OnClick(strSection,str,lngRDID,lngRID)
            {
	            //call page to add DynamicDataGrid in the detail section
	            window.open("CRW_DynamicDataGridProperties.aspx?MasterTagID=<%=m_lngMasterTagID%>&ReportID=" + lngRID + "&Section=" + strSection + "&ControlID=" + lngRDID,"","left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-500)/2 + ",height=450,width=800,resizable=no,scrollbar=no"); //WAF3_PB_42 April 17, 2007 NinadP
            }	        
	    </script>
	</body>
</HTML>
