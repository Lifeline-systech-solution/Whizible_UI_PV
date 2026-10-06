<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_TemplateApplicableRoles_CommonList.aspx.vb" Inherits="PbNIT.HR_TemplateApplicableRoles_CommonList"%>
<script type="text/javascript" language="javascript">

function ValidateControl()
{  
        var blnAllow=true;
        var objchkSave=GetObjectReference('frmCommonList','chkDelete',true);       
       
        if(objchkSave!=null)
        {
          
            var intItems = objchkSave.length;
            var i=0;
            var intCtr=0;
            for(intCtr = 0;intCtr <= intItems - 1; intCtr++)
            {
                if(objchkSave[intCtr].checked == true)
                {
                    i=i+1;
                }
            }
            if(i==0)
            {
                blnAllow=false;
                alert("No record is selected to add.");
                return false;
            }
            
        }
        
        
        
        var strParentPage='../Home/HR_TemplateApplicableRoles_CommonList.aspx?MasterTagID=3955';
        //alert(strParentPage);
       // debugger;
       // refreshParent('frmCommonPage','TNG_TrainingPrograms_CommonPage.aspx',strParentPage);
       // window.close();  
        return true;
}

function ValidateControlSaveADD()
{  
        var blnAllow=true;
        var objchkSave=GetObjectReference('frmCommonList','chkDelete',true);       
       
        if(objchkSave!=null)
        {
          
            var intItems = objchkSave.length;
            var i=0;
            var intCtr=0;
            for(intCtr = 0;intCtr <= intItems - 1; intCtr++)
            {
                if(objchkSave[intCtr].checked == true)
                {
                    i=i+1;
                }
            }
            if(i==0)
            {
                blnAllow=false;
                alert("No record is selected to add.");
                return false;
            }
            
        }
            var strParentPage='../Home/HR_TemplateApplicableRoles_CommonPage.aspx?MasterTagID=3955&TemplateID=' + <%=m_strTemplateID%> ;
            
            refreshParent('frmCommonPage','HR_TemplateApplicableRoles_CommonPage.aspx',strParentPage);
      
              
              
        return true;
        
}


</script>