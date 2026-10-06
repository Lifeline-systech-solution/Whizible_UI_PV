/* //'DECLARATION: THIS IS A FRAMEWORK CODE ITEM. IT IS NOT EXPECTED TO BE MODIFED AT THE APPLICATION LEVEL */
var objDivRptUI;
function AddToDB_OnClick(reportid) {
    //Added by Usha Pandit On 19.05.2020 For validating Task Name and Execution Template
    if (reportid == "1865") {
        if ($("#intPhaseTaskID").val() == "" || $("#intPhaseTaskID").val() == null || $("#intPhaseTaskID").val() == undefined) {
            alert("Task Name cannot be blank!");
            $("#intPhaseTaskID").focus();
            return false;
        }
    }
    if (reportid == "1867") {
        if ($("#intTemplateID").val() == "" || $("#intTemplateID").val() == null || $("#intTemplateID").val() == undefined) {
            alert("Execution Template cannot be blank!");
            $("#intTemplateID").focus();
            return false;
        }
    }
    //End Of Added by Usha Pandit On 19.05.2020 For validating Task Name and Execution Template
    window.open("../CRW/CRW_AddReportToDashboard.aspx?reportid=" + reportid, "_add2Db", "left=" + ((window.screen.width - 550) / 2) + ",top=" + ((window.screen.height - 400) / 2) + ",height=400,width=550,resizable=yes,scrollbar=yes");
}		
function Configure_OnClick(reportid)
{
    var objPKToken,strPKToken;
    objPKToken = GetObjectReference('frmDesigner','PKToken');
    if (objPKToken){strPKToken = objPKToken.value;}
	var strURL = "../CRW/CRW_ReportDesigner.aspx?reportid=" + reportid + "&MasterTagID=545&PKToken=" + strPKToken; 
	window.open(strURL,"_designer","left=50,top=50,height=600,width=600,resizable=yes,scrollbar=yes");
}
 function WhichBrowser() {

     var brwser = '';
     var ua = navigator.userAgent, tem,
     M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
     if (/trident/i.test(M[1])) {
         tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
         //return 'IE '+(tem[1] || '');
         return 'IE';
     }
     if (M[1] === 'Chrome') {
         tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
         if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
         brwser = 'CR';
     }
     else if (M[1] === 'Firefox') {
         tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
         if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
         brwser = 'FF';
     }
     M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
     if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
     //return M.join(' ');
     return brwser;
 }
function RptUI_window_onload()
{
   
    var intFillFactor=(arguments.length>0)?arguments[0]:50;
	window.status = "";
    RptUI_windowSize_common(intFillFactor);
}
function RptUI_windowSize_common(intFillFactor)
{
    
    objDivRptUI = GetObjectReference('frmReportUIBuilder', 'divList');
    if(objDivRptUI!=null) 
    {
        var intDivHeight;
        if (navigator.appName == 'Microsoft Internet Explorer')
        {intDivHeight = document.body.offsetHeight - objDivRptUI.offsetTop - intFillFactor;}
        else
        {intDivHeight = window.innerHeight - objDivRptUI.offsetTop - intFillFactor;}		
        if (intDivHeight < 100)
            intDivHeight = 100;
      
        var browser = WhichBrowser();
        if (intDivHeight != 100) { // Added By Vaijat K ON 18/11/2015
            if (browser == 'FF') {
                objDivRptUI.style.height = intDivHeight + 24 + "px";
            }
            else if (browser == 'IE') {
              //  Added and Commented By Vidya J on 26-11-2015
                //objDivRptUI.style.height = intDivHeight + 26 + "px";
                 objDivRptUI.style.height = intDivHeight + 27 + "px";
            }
            else if (browser == 'CR') {
                //  Added and Commented By Vidya J on 26-11-2015
                //objDivRptUI.style.height = intDivHeight + 27 + "px";
                 objDivRptUI.style.height = intDivHeight + 25 + "px";
            }
                else

                objDivRptUI.style.height = intDivHeight + 32 + "px";
        }
        else {

            objDivRptUI.style.height = intDivHeight + "px"; // Added By Vaijat K ON 18/11/2015
        }
    }
}