function ShowDefinition(parentId)
{
	myParent = document.getElementById("menu" + parentId)

	if (myParent.style.display=="none") {
		myParent.style.display="inline"
	} else {
		myParent.style.display="none"
	}
}

function handleParent(parentId)
  {
        myParent = document.getElementById("block" + parentId)
myImg = document.getElementById("img" +  parentId)
        if (myParent.style.display=="none") {
                  myImg.src="../../Images/help_hide.gif";
	myParent.style.display="block";
                
        } else {
                myParent.style.display="none";
myImg.src="../../Images/help_collapse.gif";
        }
  }

function handleParent1(parentId)
  {
	myParent = document.getElementById("block" + parentId);
	myImg = document.getElementById("img" +  parentId)
	myLink = document.getElementById("OP" +  parentId);
                  myParent.style.display="block";
	myImg.src="../../Images/help_hide.gif";
	myLink.focus();
      
  }

 function Help1_OnClick(HelpID)
 {
  window.open("../General/Help.aspx?HelpID=" + HelpID ,"_new","resizable=yes,scrollbars=yes,left=50,top=100,width=250,height=250");
 }

