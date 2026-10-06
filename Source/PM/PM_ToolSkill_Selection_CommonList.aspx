<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<!-- <%CommonFunctions.General.PlotPageHeadTag("")%> -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>


<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 12px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        CL_window_onload();
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Yogesh J ON 15/12/2015 for pop up bottom issue
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Remove plus(+)in Tablet and Mobile view
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        /*Generating 'id' for table row if it has no 'id'*/
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').find('tbody').find('tr').each(function () {

            var rowIndex = $(this).index();
            var attr = $(this).attr('id');
            // For some browsers, `attr` is undefined;
            // for others, `attr` is false. Check for both.
            if (typeof attr !== typeof undefined && attr !== false) {
            }

            else {
                $(this).attr('id', 'rowId' + rowIndex);
            }
        });

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('large_visible');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').after('<div id="reviewTypeContent"></div>');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
            /*$(this).find('a').css({'display':'none'});*/
            $(this).remove();

        });
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Apply Footable For Grids
        // Description:Footable is used for responsive grids that will collapse the data into the first two columns for smaller resolutions (tablets).
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        if ($('.clsGridTable').length > 0) {
            var divName = $('#divListPageTag').find('div:first').attr('id');
            dataCollapse(divName);
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/

        responsiveTopMenu();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Apply FooTable
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {
            //$('.clsTable:last').css({ 'display': 'none' });
            $('.clsTable:last').css({ 'visibility': 'hidden' });//Added  by Shamkant S on 12 Dec 2015

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:19/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/


        /* Add class to Total Record Table*/
        $('.clsBody').find('table:last').prev().prev().addClass('recordTable');


    });// Ready Function Ends

    $(window).resize(function () {
        /*window_resize_hideshowtree();*/
        CL_window_onresize();
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Yogesh J ON 15/12/2015 for pop up bottom issue
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
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();

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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {
            $('.clsTable:last').css({ 'display': 'none' });
        }
        else {
            $('.clsTable:last').css({ 'display': 'block' });
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:21/01/2015
        /*---------------------------------------------------------*/

        responsiveFooterMenuResize();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });
</script>

<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ToolSkill_Selection_CommonList.aspx.vb" Inherits="PbNIT.PM_ToolSkill_Selection_CommonList" %>

 <script>
 
 function Delete_OnClick()
 {
 
    var objParentSkillIDs = GetParentObjectReference('frmCommonPage','NonDatabase2');
    var objParentSkills = GetParentObjectReference('frmCommonPage','NonDatabase3');
//    var objCHK = GetObjectReference('','chkDelete',true);
//    var objcboSkillIDs = GetParentObjectReference('frmCommonPage','NonDatabase2');
//    var arrSelectedIDs = new Array();
//    var arrParentSkillIDs = new Array();
//    var arrSelectedCaptions = new Array();
//    var arrUnSelectedIDS = new Array();
//    arrParentSkillIDs = objParentSkillIDs.value.split(',');
//    var j,k,l,parenttbl; j=0; k=0; 
//    var SkillIDs='',Skills='',str1='',strChk='';
//    var Flag=0
//    var objProjectSkills = GetParentObjectReference('frmCommonPage','NonDatabase4');

//    for (i=0;i<objProjectSkills.length;i++)
//    {
//          str1=str1 +','+objProjectSkills.options[i].text;
//    }
//    str1=str1.replace(',,',',')+',';
//    var str1 = objProjectSkills.value;
//    var patt2 ;
//    var str = ','+objParentSkillIDs.value;
//    var patt1,alertSkill ;

//        for(var i=0;i<objCHK.length;i++)
//        {  
//	        if(objCHK[i].checked == true) 
//	        {          
//                  Flag=1;
//                  strChk=strChk+','+objCHK[i].value;
//                  patt1=new RegExp(','+objCHK[i].value+',');
//                  if(patt1.test(str1))
//                  {
//                    parentTR = objCHK[i].parentNode;
//                    while(parentTR)
//                    {
//                        if(parentTR.tagName && parentTR.tagName=="TR")
//                        break; parentTR = parentTR.parentNode;
//                    }
//                    if(parentTR && parentTR.tagName=="TR") 
//                    {  alertSkill= parentTR.cells[0].innerHTML;}
//                        alert('Tool/Skill ['+alertSkill+'] is already on project');
//                        return;
//                    }

//                     if(!patt1.test(str))
//                    
//                  if(!patt1.test(strChk))
//                  {
//                        SkillIDs = SkillIDs + objCHK[i].value +',';
//                             str = str + SkillIDs;

//                        parentTR = objCHK[i].parentNode;
//                        while(parentTR)
//                        {
//                        if(parentTR.tagName && parentTR.tagName=="TR")
//                        break; parentTR = parentTR.parentNode;
//                        }
//                        if(parentTR && parentTR.tagName=="TR")  Skills = Skills +  parentTR.cells[0].innerHTML + ',' ; k++;
//                  }  
//                 

//            }
//                     
//        }
//        if(Flag==0)
//        {
//        alert('Please select at least one skill or tool');
//        return;
//        }
//    strChk=strChk.substring(1);
//    objParentSkillIDs.value = strChk.substring(1)+',';
//    var strDeselect='';
//    for(l=0;l<arrParentSkillIDs.length;l++)
//    {
//        if(strChk.indexOf(arrParentSkillIDs[l]=-1))
//        {
//            strDeselect=strDeselect+','+arrParentSkillIDs[l];
//        }
//         arrParentSkillIDs[j].contains
//    }

//    objParentSkillIDs.value = objParentSkillIDs.value  + SkillIDs;
//    objParentSkills.value = objParentSkills.value + Skills; 
//    if (Right(Skills,1) == ",")
//        objParentSkills.value =  Skills.substring(0,Skills.length-1);
//    else
//        objParentSkills.value =  Skills;
 
 var objchkDelete = GetObjectReference("","chkDelete",true);
    var objSelectedIDs = GetObjectReference('','SelectedIDs');
    var objSelectedSkills = GetObjectReference('','SelectedSkill');
    var strSelectedIDs = GetObjectReference('','SelectedIDs').value ;
    var strSelectedSkills =GetObjectReference('','SelectedSkill').value;
    
        for(var i=0;i<objchkDelete.length;i++)
        {  
            var objDescription = GetObjectReference('','txtDescription',true); 
	        if(objchkDelete[i].checked == true && (","+strSelectedIDs+",").indexOf(","+objchkDelete[i].value+",")<0) 
             {     
                  strSelectedIDs+= objchkDelete[i].value + ",";
                  strSelectedSkills  +=  objDescription[i].value + ",";
             }
             else if(objchkDelete[i].checked == false && (","+strSelectedIDs+",").indexOf(","+objchkDelete[i].value+",")>=0) 
             {
                  strSelectedIDs = strSelectedIDs.replace(objchkDelete[i].value,"")
                  strSelectedSkills =  strSelectedSkills.replace(objDescription[i].value,"");
             }
        }
        
        if (Left(strSelectedSkills,1) == ',')
        {
            strSelectedSkills = Right(strSelectedSkills,strSelectedSkills.length-1); //Left(strSelectedSkills,1,strSelectedSkills.length)                        
        }
        strSelectedSkills = replaceSubstring(strSelectedSkills,',,',',')
        
        if (Right(strSelectedSkills,strSelectedSkills.length) == ',')
        {
            strSelectedSkills = Left(strSelectedSkills,strSelectedSkills.length-1)
        }
            strSelectedSkills = replaceSubstring(strSelectedSkills,',,',',')
        
        if (Left(strSelectedIDs,0) == ',')
        {
            strSelectedIDs = Left(strSelectedIDs,1+strSelectedIDs.length)
        }
            strSelectedIDs = replaceSubstring(strSelectedIDs,',,',',')
        if (Right(strSelectedIDs,strSelectedSkills.length) == ',')
        {
            strSelectedIDs = Right(strSelectedIDs,strSelectedIDs.length-1)
         }   
           strSelectedIDs = replaceSubstring(strSelectedIDs,',,',',')
            
            
            
        if (Left(strSelectedSkills,0) == ',')
        {
            strSelectedSkills = Left(strSelectedSkills,1+strSelectedSkills.length)                        
        }
        objSelectedSkills.value = strSelectedSkills;
        objSelectedIDs.value = strSelectedIDs;
        
        

    objParentSkillIDs.value = objSelectedIDs.value;
    objParentSkills.value = objSelectedSkills.value;
    window.close();
    
    return;
    }


function chkDelete_onClick(ToolID)
{
  
   
//    if (objchkDelete.checked == true)
//    {
//       GetParentObjectReference('frmCommonPage','NonDatabase2').value  += ToolID + ",";
//       GetParentObjectReference('frmCommonPage','NonDatabase3').value  += "'" +ToolDescription + "',";
//    }

}

 </script>