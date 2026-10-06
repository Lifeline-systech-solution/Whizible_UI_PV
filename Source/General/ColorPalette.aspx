<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ColorPalette.aspx.vb" Inherits="Whiz.ColorPalette" %>

<!DOCTYPE HTML>
<HTML>
<%CommonFunctions.General.PlotPageHeadTag("Color Palette")%>
<body MS_POSITIONING="GridLayout" bgcolor="white" class="clsBody" onload="window_onload()">
<style type="text/css">
span.clsColor
{
    cursor: pointer;
    border-style: outset;
    border-color: #d4d0c8;
    border-width: 1px;
    height: 16px;
    width: 16px;
    margin-top: 2px;
    margin-bottom: 2px;
    margin-left: 2px;
    margin-right: 2px;
}
span.clsColorNetScap
{
    cursor: pointer;
    font-size: small;
    border-style: outset;
    border-color: #d4d0c8;
    border-width: 1px;
    margin-left: 0;
    margin-right: 0;
}
</style>
<script language='javascript'>
function window_onload()
{
if (navigator.appName != 'Microsoft Internet Explorer')
{
    var objSpan = GetObjectReference("","spnColor",true);
		var intItems;var intCtr;		
		if (objSpan != null)
		{
			intItems = objSpan.length;						
			if(intItems > 1) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
				    objSpan[intCtr].innerHTML='&nbsp;&nbsp;&nbsp;';		
				    objSpan[intCtr].className='clsColorNetScap';	
				}
			}
		}
}	
return;	
}
</script>
<table width="100%" ><tr class=clsTRSectionHeader><td>Basic:</td></tr> </table >
    <span name="spnColor" style="background-color: green" title="Green" onclick="FillColor('Green')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: lime" title="Lime"  onclick="FillColor('Lime')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: teal" title="Teal"  onclick="FillColor('Teal')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: aqua" title="Aqua"  onclick="FillColor('Aqua')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: navy" title="Navy"  onclick="FillColor('Navy')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: blue" title="Blue"  onclick="FillColor('Blue')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: purple" title="Purple"  onclick="FillColor('Purple')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: fuchsia" title="Fuchsia"  onclick="FillColor('Fuchsia')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: maroon" title="Maroon"  onclick="FillColor('Maroon')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: red" title="Red"  onclick="FillColor('Red')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: olive" title="Olive"  onclick="FillColor('Olive')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: yellow" title="Yellow"  onclick="FillColor('Yellow')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: white" title='White'  onclick="FillColor('White')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: silver" title="Silver"  onclick="FillColor('Silver')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: gray" title="Gray"  onclick="FillColor('Gray')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: black" title="Black"  onclick="FillColor('Black')" class="clsColor" ></span>
<br />
<br />
<table width="100%"><tr class=clsTRSectionHeader><td>Additional:</td></tr> </table >
    <span name="spnColor" style="background-color: darkolivegreen" title="Dark Olive Green"  onclick="FillColor('Darkolivegreen')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkgreen" title="Dark Green"  onclick="FillColor('Darkgreen')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkslategray" title="Dark Slate Gray"  onclick="FillColor('Darkslategray')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: slategray" title="Slate Gray"  onclick="FillColor('Slategray')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkblue" title="Dark Blue"  onclick="FillColor('Darkblue')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: midnightblue" title="Midnight Blue"  onclick="FillColor('Midnightblue')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: indigo" title="Indigo"  onclick="FillColor('Indigo')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkmagenta" title="Dark Magenta"  onclick="FillColor('Darkmagenta')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: brown" title="Brown"  onclick="FillColor('Brown')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkred" title="Dark Red"  onclick="FillColor('Darkred')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: sienna" title="Sienna"  onclick="FillColor('Sienna')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: saddlebrown" title="Saddle Brown"  onclick="FillColor('SaddleBrown')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkgoldenrod" title="Dark Goldenrod"  onclick="FillColor('Darkgoldenrod')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: Beige" title="Beige"  onclick="FillColor('Beige')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: honeydew" title="Honeydew"  onclick="FillColor('Honeydew')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: dimgray" title="Dim gray"  onclick="FillColor('Dimgray')" class="clsColor" ></span>
<br />
    <script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
    <span name="spnColor" style="background-color: olivedrab" title="Olivedrab"  onclick="FillColor('Olivedrab')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: forestgreen" title="Forest Green"  onclick="FillColor('Forestgreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: darkcyan" title="Dark Cyan"  onclick="FillColor('Darkcyan')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: Lightslategray" title="Light Slate Gray"  onclick="FillColor('Lightslategray')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: mediumblue" title="Medium Blue"  onclick="FillColor('Mediumblue')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkslateblue" title="Dark Slate Green"  onclick="FillColor('Darkslateblue')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkviolet" title="Dark Violet"  onclick="FillColor('Darkviolet')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: mediumvioletred" title="Medium Violet Red"  onclick="FillColor('Mediumvioletred')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: indianred" title="Indian Red"  onclick="FillColor('IndianRed')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: firebrick" title="Fire Brick"  onclick="FillColor('Firebrick')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: chocolate" title="Chocolate"  onclick="FillColor('Chocolate')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: peru" title="Peru"  onclick="FillColor('Peru')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: goldenrod" title="Goldenrod"  onclick="FillColor('Goldenrod')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: lightgoldenrodyellow" title="Light Goldenrod Yellow"  onclick="FillColor('Lightgoldenrodyellow')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: mintcream" title="Mint Cream"  onclick="FillColor('MintCream')" class="clsColor" ></span>
	<span name="spnColor" style="background-color: darkgray" title="Dark Grey"  onclick="FillColor('Darkgray')" class="clsColor" ></span>

<br />
<script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
    <span name="spnColor" style="background-color: yellowgreen" title="Yellow Green"  onclick="FillColor('Yellowgreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: seagreen" title="Sea Green"  onclick="FillColor('Seagreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: cadetblue" title="Cadet Blue"  onclick="FillColor('Cadetblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: steelblue" title="Steel Blue"  onclick="FillColor('Steelblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: royalblue" title="Royal Blue"  onclick="FillColor('RoyalBlue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: BlueViolet" title="Blue Violet"  onclick="FillColor('BlueViolet')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: darkorchid" title="Dark Orchid"  onclick="FillColor('Darkorchid')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: deeppink" title="Deep Pink"  onclick="FillColor('Deeppink')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: rosybrown" title="Rosy Brown"  onclick="FillColor('RosyBrown')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: crimson" title="Crimson"  onclick="FillColor('Crimson')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: darkorange" title="Dark Orange"  onclick="FillColor('Darkorange')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: burlywood" title="Burlywood"  onclick="FillColor('Burlywood')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: darkkhaki" title="Dark Khaki"  onclick="FillColor('Darkkhaki')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightyellow" title="Light Yellow"  onclick="FillColor('Lightyellow')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: azure" title="Azure"  onclick="FillColor('Azure')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightgrey" title="Light Grey"  onclick="FillColor('Lightgrey')" class="clsColor" ></span>
<br />
<script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
    <span name="spnColor" style="background-color: lawngreen" title="Lawn Green"  onclick="FillColor('LawnGreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: mediumseagreen" title="Medium Sea Green"  onclick="FillColor('Mediumseagreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightseagreen" title="Light Sea Green"  onclick="FillColor('Lightseagreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: deepskyblue" title="Deep Sky Blue"  onclick="FillColor('Deepskyblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: dodgerblue" title="Dodger Blue"  onclick="FillColor('Dodgerblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: slateblue" title="Slate Blue"  onclick="FillColor('Slateblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: MediumOrchid" title="Medium Orchid"  onclick="FillColor('MediumOrchid')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: palevioletred" title="Pale Violet Red"  onclick="FillColor('PaleVioletRed')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: salmon" title="Salmon"  onclick="FillColor('salmon')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: orangered" title="Orange Red"  onclick="FillColor('OrangeRed')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: sandybrown" title="Sandy Brown"  onclick="FillColor('SandyBrown')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: tan" title="Tan"  onclick="FillColor('Tan')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: gold" title="Gold"  onclick="FillColor('Gold')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: ivory" title="Ivory"  onclick="FillColor('Ivory')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: ghostwhite" title="Ghost White"  onclick="FillColor('Ghostwhite')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: gainsboro" title="Gains Boro"  onclick="FillColor('Gainsboro')" class="clsColor" ></span>
<br />
<script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
    <span name="spnColor" style="background-color: chartreuse" title="Chartreuse"  onclick="FillColor('Chartreuse')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: limegreen" title="Lime Green"  onclick="FillColor('Limegreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: mediumaquamarine" title="Medium Aqua Marine"  onclick="FillColor('Mediumaquamarine')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: darkturquoise" title="Dark Turquoise"  onclick="FillColor('Darkturquoise')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: cornflowerblue" title="Corn Flower Blue"  onclick="FillColor('Cornflowerblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: mediumslateblue" title="Medium Slate Blue"  onclick="FillColor('mediumslateblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: orchid" title="Orchid"  onclick="FillColor('Orchid')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: hotpink" title="Hot Pink"  onclick="FillColor('HotPink')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightcoral" title="Light Coral"  onclick="FillColor('LightCoral')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: tomato" title="Tomato"  onclick="FillColor('Tomato')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: orange" title="Orange"  onclick="FillColor('Orange')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: bisque" title="Bisque"  onclick="FillColor('Bisque')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: khaki" title="Khaki"  onclick="FillColor('Khaki')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: cornsilk" title="Corn Silk"  onclick="FillColor('Cornsilk')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: linen" title="Linen"  onclick="FillColor('Linen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: whitesmoke" title="White Smoke"  onclick="FillColor('Whitesmoke')" class="clsColor" ></span>
<br />
<script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
    <span name="spnColor" style="background-color: greenyellow" title="Green Yellow"  onclick="FillColor('Greenyellow')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: darkseagreen" title="Dark Sea Green"  onclick="FillColor('Darkseagreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: turquoise" title="Turquoise"  onclick="FillColor('Turquoise')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: mediumturquoise" title="Medium Turquoise"  onclick="FillColor('Mediumturquoise')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: skyblue" title="Sky Blue"  onclick="FillColor('SkyBlue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: mediumpurple" title="Medium Purple"  onclick="FillColor('Mediumpurple')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: violet" title="Violet"  onclick="FillColor('Violet')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightpink" title="Light Pink"  onclick="FillColor('Lightpink')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: darksalmon" title="Dark Salmon"  onclick="FillColor('Darksalmon')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: coral" title="Coral"  onclick="FillColor('Coral')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: navajowhite" title="Navajo White"  onclick="FillColor('Navajowhite')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: blanchedalmond" title="Blanched Almond"  onclick="FillColor('Blanchedalmond')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: palegoldenrod" title="Pale Goldenrod"  onclick="FillColor('PaleGoldenrod')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: oldlace" title="Oldlace"  onclick="FillColor('Oldlace')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: seashell" title="Sea Shell"  onclick="FillColor('Seashell')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: ghostwhite" title="Ghost White"  onclick="FillColor('Ghostwhite')" class="clsColor" ></span>
<br />
<script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
    <span name="spnColor" style="background-color: palegreen" title="Pale Green"  onclick="FillColor('Palegreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: springgreen" title="Spring Green"  onclick="FillColor('Springgreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: aquamarine" title="Aquamarine"  onclick="FillColor('Aquamarine')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: powderblue" title="Powder Blue"  onclick="FillColor('PowderBlue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightskyblue" title="Light Sky Blue"  onclick="FillColor('Lightskyblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightsteelblue" title="Light Steel Blue"  onclick="FillColor('Lightsteelblue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: plum" title="Plum"  onclick="FillColor('Plum')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: pink" title="Pink"  onclick="FillColor('Pink')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightsalmon" title="Light Salmon"  onclick="FillColor('Lightsalmon')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: wheat" title="Wheat"  onclick="FillColor('Wheat')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: moccasin" title="Moccasin"  onclick="FillColor('Moccasin')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: antiquewhite" title="Antique White"  onclick="FillColor('Antiquewhite')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lemonchiffon" title="Lemon Chiffon"  onclick="FillColor('Lemonchiffon')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: floralwhite" title="Floral White"  onclick="FillColor('Floralwhite')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: snow" title="Snow"  onclick="FillColor('Snow')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: aliceblue" title="Alice Blue"  onclick="FillColor('Aliceblue')" class="clsColor" ></span>
<br />
<script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
    <span name="spnColor" style="background-color: lightgreen" title="Light Green"  onclick="FillColor('LightGreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: mediumspringgreen" title="Medium Spring Green"  onclick="FillColor('Mediumspringgreen')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: paleturquoise" title="Pale Turquoise"  onclick="FillColor('Paleturquoise')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: cyan" title="Cyan"  onclick="FillColor('Cyan')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightcyan" title="Light Cyan"  onclick="FillColor('LightCyan')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lightblue" title="Light Blue"  onclick="FillColor('LightBlue')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: magenta" title="Magenta"  onclick="FillColor('Magenta')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: thistle" title="Thistle"  onclick="FillColor('Thistle')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: peachpuff" title="Peachpuff"  onclick="FillColor('Peachpuff')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: mistyrose" title="Misty Rose"  onclick="FillColor('Mistyrose')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: papayawhip" title="Papaya Whip"  onclick="FillColor('Papayawhip')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lavenderblush" title="Lavender Blush"  onclick="FillColor('Lavenderblush')" class="clsColor" ></span>
    <span name="spnColor" style="background-color: lavender" title="Lavender"  onclick="FillColor('Lavender')" class="clsColor" ></span>
    <span title="None" style="vertical-align:text-top">|<a class="Menu" title="Clear Selection"  onclick="FillColor('')" ><u>None</u></a>|</span>  
<script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
<script language='javascript'>if (navigator.appName != 'Microsoft Internet Explorer') document.write("<br />")</script>
</TABLE>
<script>
function Close_OnClick()
{
 window.close();
}
function ShowSelected()
{
    var oSpans=document.getElementsByTagName('SPAN');
    var iLoop=0,iLen=0;
    iLen=oSpans.length;
    var sColorFromQS='<%=m_strColorValue%>';
    for (iLoop=0;iLoop<iLen;iLoop++)
    {
        if (oSpans[iLoop].style.backgroundColor.toUpperCase()==sColorFromQS.toUpperCase())
        {
            oSpans[iLoop].style.border='2px dashed black';
            break;
        }
    }
}
ShowSelected();
function FillColor(Color)
{
    try
    {
        if(window.opener==null)
        {   alert("<%=m_strMsg_OpenerWinClose%>");
            window.close();
        }
        else
        {
            var objParentTextBox=GetParentObjectReference('<%=m_strFormName%>','<%=m_strColorField%>');
            objParentTextBox.value=Color;
            objParentTextBox.style.background= Color;
            if (Color!=null && Color!='')
            {
                if (IsDarkColor(Color)==true)
                    objParentTextBox.style.color="white";
                else
                    objParentTextBox.style.color="black";
            }
            else
                objParentTextBox.style.background="white";
        }
    }
    catch(err){} 
    window.close();
}
</script>
</body>
</HTML>