//Common Functions
function formatValue(obj)
{
	if (!isBlank(obj.value)) {
		var value=obj.value; 
		if(!isNaN(value)) 
		{
			value=eval(value);
			value=value.toFixed(2);
			obj.value=value;
		} 
		
		   
		else {return false;}

	}
	
	return true;
}




function evalValue(value)
{
	
	var replace=(arguments.length>1)?arguments[1]:0;
	if (isBlank(value)) {return eval(replace);}
	return eval(value);
}



//------------------CreateRecordOnChange()
function CreateRecordOnChange()
{
	var objCreateRecord = GetObjectReference('frmCommonList','CreateRecord')
	if (objCreateRecord==null) return;
	
	window.location.href="SaaS_CommonPage.aspx?Mode=ADD_NEW&MasterTagID=" + objCreateRecord.value + "&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
}



//-----------------------------------------------------------------------------------------------------------------------------------
//				Page Specific Functions
//-----------------------------------------------------------------------------------------------------------------------------------
/*
	Function Name	:	calculateTotalCredit
	Description		:	Calculate the Total Credit
	Page	Name	:	RMA Credit Details
*/
function calculateTotalCredit()
{
var objProductCredit=GetObjectReference('frmCommonPage','ProductCredit');
var objShippingCredit=GetObjectReference('frmCommonPage','ShippingCredit');
var objTaxCredit=GetObjectReference('frmCommonPage','TaxCredit');
var objOtherCredit=GetObjectReference('frmCommonPage','OtherCredit');
var objTotalCredit=GetObjectReference('frmCommonPage','TotalCredit');
var valTotalCredit;

if (!formatValue(objProductCredit)) return;
if (!formatValue(objShippingCredit)) return;
if (!formatValue(objTaxCredit)) return;
if (!formatValue(objOtherCredit)) return;
valTotalCredit=0;
valTotalCredit =  evalValue(objProductCredit.value) + evalValue(objShippingCredit.value) + evalValue(objTaxCredit.value) + evalValue(objOtherCredit.value);
if (!isNaN(valTotalCredit)) {objTotalCredit.value =valTotalCredit.toFixed(2);}

}

/* ################################################################################################################################################################################## */
/* ################################################################################################################################################################################## */

/*
	Function Name	:	calculatePointsEarned
	Description		:	Calculate the Points Earned
	Page	Name	:	Student List	
*/
function calculatePointsEarned()
{
var objPoints1=GetObjectReference('frmCommonPage','Points1');
var objPoints2=GetObjectReference('frmCommonPage','Points2');
var objPoints3=GetObjectReference('frmCommonPage','Points3');
var objPoints4=GetObjectReference('frmCommonPage','Points4');
var objPoints5=GetObjectReference('frmCommonPage','Points5');
var objPoints6=GetObjectReference('frmCommonPage','Points6');
var objPoints7=GetObjectReference('frmCommonPage','Points7');
var objPoints8=GetObjectReference('frmCommonPage','Points8');
var objPoints9=GetObjectReference('frmCommonPage','Points9');
var objPoints10=GetObjectReference('frmCommonPage','Points10');
var objPointsEarned=GetObjectReference('frmCommonPage','PointsEarned');
var valPointsEarned;

if (!formatValue(objPoints1)) return;
if (!formatValue(objPoints2)) return;
if (!formatValue(objPoints3)) return;
if (!formatValue(objPoints4)) return;
if (!formatValue(objPoints5)) return;
if (!formatValue(objPoints6)) return;
if (!formatValue(objPoints7)) return;
if (!formatValue(objPoints8)) return;
if (!formatValue(objPoints9)) return;
if (!formatValue(objPoints10)) return;
valPointsEarned=0;
valPointsEarned =  evalValue(objPoints1.value) + evalValue(objPoints2.value) + evalValue(objPoints3.value) + evalValue(objPoints4.value) + evalValue(objPoints5.value) + evalValue(objPoints6.value) + evalValue(objPoints7.value) + evalValue(objPoints8.value) + evalValue(objPoints9.value) + evalValue(objPoints10.value);
if (!isNaN(valPointsEarned)) {objPointsEarned.value =valPointsEarned.toFixed(2);}

}


/* ################################################################################################################################################################################## */
/* ################################################################################################################################################################################## */


/*
	Function Name	:	calculatePointsPossible
	Description		:	Calculate the Points Possible 
	Page	Name	:	Student List	
*/
function calculatePointsPossible()
{
var objPossible1=GetObjectReference('frmCommonPage','Possible1');
var objPossible2=GetObjectReference('frmCommonPage','Possible2');
var objPossible3=GetObjectReference('frmCommonPage','Possible3');
var objPossible4=GetObjectReference('frmCommonPage','Possible4');
var objPossible5=GetObjectReference('frmCommonPage','Possible5');
var objPossible6=GetObjectReference('frmCommonPage','Possible6');
var objPossible7=GetObjectReference('frmCommonPage','Possible7');
var objPossible8=GetObjectReference('frmCommonPage','Possible8');
var objPossible9=GetObjectReference('frmCommonPage','Possible9');
var objPossible10=GetObjectReference('frmCommonPage','Possible10');
var objPointsPossible=GetObjectReference('frmCommonPage','PointsPossible');
var valPointsPossible;

if (!formatValue(objPossible1)) return;
if (!formatValue(objPossible2)) return;
if (!formatValue(objPossible3)) return;
if (!formatValue(objPossible4)) return;
if (!formatValue(objPossible5)) return;
if (!formatValue(objPossible6)) return;
if (!formatValue(objPossible7)) return;
if (!formatValue(objPossible8)) return;
if (!formatValue(objPossible9)) return;
if (!formatValue(objPossible10)) return;
valPointsPossible=0;
valPointsPossible =  evalValue(objPossible1.value) + evalValue(objPossible2.value) + evalValue(objPossible3.value) + evalValue(objPossible4.value) + evalValue(objPossible5.value) + evalValue(objPossible6.value) + evalValue(objPossible7.value) + evalValue(objPossible8.value) + evalValue(objPossible9.value) + evalValue(objPossible10.value);
if (!isNaN(valPointsPossible)) {objPointsPossible.value =valPointsPossible.toFixed(2);}

}

/* ################################################################################################################################################################################## */
/*										     SHOBHIT's FUNCTIONS														*/
/* ################################################################################################################################################################################## */
/*
	Function Name	:	calculateTotal()
	Description	    :	Calculate the Total Donation Amount
	Page	Name	:	Donation	
*/
function calculateDonTotal()
{
var objAmount1=GetObjectReference('frmCommonPage','Amount1');
var objAmount2=GetObjectReference('frmCommonPage','Amount2');
var objAmount3=GetObjectReference('frmCommonPage','Amount3');
var objAmount4=GetObjectReference('frmCommonPage','Amount4');
var objAmount5=GetObjectReference('frmCommonPage','Amount5');
var objTotal=GetObjectReference('frmCommonPage','Total');
var valTotal;

if (!formatValue(objAmount1)) return;
if (!formatValue(objAmount2)) return;
if (!formatValue(objAmount3)) return;
if (!formatValue(objAmount4)) return;
if (!formatValue(objAmount5)) return;

valTotal=0;
valTotal =  evalValue(objAmount1.value) + evalValue(objAmount2.value) + evalValue(objAmount3.value) + evalValue(objAmount4.value) + evalValue(objAmount5.value);
if (!isNaN(valTotal)) {objTotal.value =valTotal.toFixed(2);}

}
/* ****************************************************************************************************************************************************************** */
/* ****************************************************************************************************************************************************************** */

/*
	Function Name	:	calculateTotal()
	Description		:	Calculate the Total Item Cost 
	Page Name		:	Marketing Programs	
*/
function MktPrgs_calculateTotal()
{
var objAmount1=GetObjectReference('frmCommonPage','Amount1');
var objAmount2=GetObjectReference('frmCommonPage','Amount2');
var objAmount3=GetObjectReference('frmCommonPage','Amount3');
var objAmount4=GetObjectReference('frmCommonPage','Amount4');
var objAmount5=GetObjectReference('frmCommonPage','Amount5');
var objTotal=GetObjectReference('frmCommonPage','Total');
var valTotal;

if (!formatValue(objAmount1)) return;
if (!formatValue(objAmount2)) return;
if (!formatValue(objAmount3)) return;
if (!formatValue(objAmount4)) return;
if (!formatValue(objAmount5)) return;

valTotal=0;
valTotal =  evalValue(objAmount1.value) + evalValue(objAmount2.value) + evalValue(objAmount3.value) + evalValue(objAmount4.value) + evalValue(objAmount5.value);
if (!isNaN(valTotal)) {objTotal.value =valTotal.toFixed(2);}

}
/* ****************************************************************************************************************************************************************** */
/* ****************************************************************************************************************************************************************** */

/*
	Function Name	:	calculateProfitFromSale()
	Description		:	Calculate the Total Profit From Sale of the Asset 
	Page Name		:	Assets	
*/

function calcProfitFromSale_Asset()
{
var objSalePrice=GetObjectReference('frmCommonPage','SalePrice');
var objPurchasePrice=GetObjectReference('frmCommonPage','PurchasePrice');
var objProfitFromSale=GetObjectReference('frmCommonPage','ProfitFromSale');
var valProfitFromSale;

if (!formatValue(objSalePrice)) return;
if (!formatValue(objPurchasePrice)) return;

valProfitFromSale = 0;
valProfitFromSale = evalValue(objSalePrice.value) - evalValue(objPurchasePrice.value) ;

if (!isNaN(valProfitFromSale)) {objProfitFromSale.value = valProfitFromSale.toFixed(2);}
}
/* ****************************************************************************************************************************************************************** */
/* ****************************************************************************************************************************************************************** */

/*
	Function Name	:	AccountRecformatVal()
	Description		:	Format the value of POAmount to 2 decimal palces 
	Page Name		:	Account Receivable
*/
function AccountRecformatVal()
{
	var objPOAmount = GetObjectReference('frmCommonPage','POAmount');
    if (!formatValue(objPOAmount)) return;
}
/* ****************************************************************************************************************************************************************** */
/* ****************************************************************************************************************************************************************** */
/* ##################################################  END  ######################################################################################################################## */
/* ################################################################################################################################################################################## */



/*
	Function Name	:	calculateTotalBill
	Description		:	Calculate the Total Bill
	Page	Name	:	Bill Pay History
*/
function calculateTotalBill()
{
var objBillAmount1=GetObjectReference('frmCommonPage','BillAmount1');
var objBillAmount2=GetObjectReference('frmCommonPage','BillAmount2');
var objBillAmount3=GetObjectReference('frmCommonPage','BillAmount3');
var objBillAmount4=GetObjectReference('frmCommonPage','BillAmount4');
var objBillAmount5=GetObjectReference('frmCommonPage','BillAmount5');
var objBillAmount6=GetObjectReference('frmCommonPage','BillAmount6');
var objBillAmount7=GetObjectReference('frmCommonPage','BillAmount7');
var objBillAmount8=GetObjectReference('frmCommonPage','BillAmount8');
var objBillAmount9=GetObjectReference('frmCommonPage','BillAmount9');
var objBillAmount10=GetObjectReference('frmCommonPage','BillAmount10');
var objBillAmount11=GetObjectReference('frmCommonPage','BillAmount11');
var objBillAmount12=GetObjectReference('frmCommonPage','BillAmount12');
var objTotalBill=GetObjectReference('frmCommonPage','TotalBill');
var valTotalBill;


if (!formatValue(objBillAmount1)) return;
if (!formatValue(objBillAmount2)) return;
if (!formatValue(objBillAmount3)) return;
if (!formatValue(objBillAmount4)) return;
if (!formatValue(objBillAmount5)) return;
if (!formatValue(objBillAmount6)) return;
if (!formatValue(objBillAmount7)) return;
if (!formatValue(objBillAmount8)) return;
if (!formatValue(objBillAmount9)) return;
if (!formatValue(objBillAmount10)) return;
if (!formatValue(objBillAmount11)) return;
if (!formatValue(objBillAmount12)) return;

valTotalBill=0;
valTotalBill =  evalValue(objBillAmount1.value) + evalValue(objBillAmount2.value) + evalValue(objBillAmount3.value) + evalValue(objBillAmount4.value) + evalValue(objBillAmount5.value) + evalValue(objBillAmount6.value) + evalValue(objBillAmount7.value) + evalValue(objBillAmount8.value) + evalValue(objBillAmount9.value) + evalValue(objBillAmount10.value) + evalValue(objBillAmount11.value) + evalValue(objBillAmount12.value);
if (!isNaN(valTotalBill)) {objTotalBill.value =valTotalBill.toFixed(2);}
}


/*
	Function Name	:	calculateTotalAmountPaid
	Description		:	Calculate the Total Amount Paid
	Page	Name	:	Bill Pay History
*/
function calculateTotalAmountPaid()
{
var objAmountPaid1=GetObjectReference('frmCommonPage','AmountPaid1');
var objAmountPaid2=GetObjectReference('frmCommonPage','AmountPaid2');
var objAmountPaid3=GetObjectReference('frmCommonPage','AmountPaid3');
var objAmountPaid4=GetObjectReference('frmCommonPage','AmountPaid4');
var objAmountPaid5=GetObjectReference('frmCommonPage','AmountPaid5');
var objAmountPaid6=GetObjectReference('frmCommonPage','AmountPaid6');
var objAmountPaid7=GetObjectReference('frmCommonPage','AmountPaid7');
var objAmountPaid8=GetObjectReference('frmCommonPage','AmountPaid8');
var objAmountPaid9=GetObjectReference('frmCommonPage','AmountPaid9');
var objAmountPaid10=GetObjectReference('frmCommonPage','AmountPaid10');
var objAmountPaid11=GetObjectReference('frmCommonPage','AmountPaid11');
var objAmountPaid12=GetObjectReference('frmCommonPage','AmountPaid12');
var objTotalAmountPaid=GetObjectReference('frmCommonPage','TotalAmountPaid');
var valTotalAmountPaid;



if (!formatValue(objAmountPaid1)) return;
if (!formatValue(objAmountPaid2)) return;
if (!formatValue(objAmountPaid3)) return;
if (!formatValue(objAmountPaid4)) return;
if (!formatValue(objAmountPaid5)) return;
if (!formatValue(objAmountPaid6)) return;
if (!formatValue(objAmountPaid7)) return;
if (!formatValue(objAmountPaid8)) return;
if (!formatValue(objAmountPaid9)) return;
if (!formatValue(objAmountPaid10)) return;
if (!formatValue(objAmountPaid11)) return;
if (!formatValue(objAmountPaid12)) return;



valTotalAmountPaid=0;
valTotalAmountPaid =  evalValue(objAmountPaid1.value) + evalValue(objAmountPaid2.value) + evalValue(objAmountPaid3.value) + evalValue(objAmountPaid4.value) + evalValue(objAmountPaid5.value) + evalValue(objAmountPaid6.value) + evalValue(objAmountPaid7.value) + evalValue(objAmountPaid8.value) + evalValue(objAmountPaid9.value) + evalValue(objAmountPaid10.value) + evalValue(objAmountPaid11.value) + evalValue(objAmountPaid12.value);
if (!isNaN(valTotalAmountPaid)) {objTotalAmountPaid.value = valTotalAmountPaid.toFixed(2);}
CalculateTotalBalanceAmount()

}






/*
	Function Name	:	calculateTotalBalanceAmount
	Description		:	Calculate the Total Amount Paid
	Page	Name	:	Bill Pay History
*/

function CalculateTotalBalanceAmount()
{
var objAmountPaid1=GetObjectReference('frmCommonPage','AmountPaid1');
var objAmountPaid2=GetObjectReference('frmCommonPage','AmountPaid2');
var objAmountPaid3=GetObjectReference('frmCommonPage','AmountPaid3');
var objAmountPaid4=GetObjectReference('frmCommonPage','AmountPaid4');
var objAmountPaid5=GetObjectReference('frmCommonPage','AmountPaid5');
var objAmountPaid6=GetObjectReference('frmCommonPage','AmountPaid6');
var objAmountPaid7=GetObjectReference('frmCommonPage','AmountPaid7');
var objAmountPaid8=GetObjectReference('frmCommonPage','AmountPaid8');
var objAmountPaid9=GetObjectReference('frmCommonPage','AmountPaid9');
var objAmountPaid10=GetObjectReference('frmCommonPage','AmountPaid10');
var objAmountPaid11=GetObjectReference('frmCommonPage','AmountPaid11');
var objAmountPaid12=GetObjectReference('frmCommonPage','AmountPaid12');



var objBillAmount1=GetObjectReference('frmCommonPage','BillAmount1');
var objBillAmount2=GetObjectReference('frmCommonPage','BillAmount2');
var objBillAmount3=GetObjectReference('frmCommonPage','BillAmount3');
var objBillAmount4=GetObjectReference('frmCommonPage','BillAmount4');
var objBillAmount5=GetObjectReference('frmCommonPage','BillAmount5');
var objBillAmount6=GetObjectReference('frmCommonPage','BillAmount6');
var objBillAmount7=GetObjectReference('frmCommonPage','BillAmount7');
var objBillAmount8=GetObjectReference('frmCommonPage','BillAmount8');
var objBillAmount9=GetObjectReference('frmCommonPage','BillAmount9');
var objBillAmount10=GetObjectReference('frmCommonPage','BillAmount10');
var objBillAmount11=GetObjectReference('frmCommonPage','BillAmount11');
var objBillAmount12=GetObjectReference('frmCommonPage','BillAmount12');

var objAccountBalance1=GetObjectReference('frmCommonPage','AccountBalance1');
var objAccountBalance2=GetObjectReference('frmCommonPage','AccountBalance2');
var objAccountBalance3=GetObjectReference('frmCommonPage','AccountBalance3');
var objAccountBalance4=GetObjectReference('frmCommonPage','AccountBalance4');
var objAccountBalance5=GetObjectReference('frmCommonPage','AccountBalance5');
var objAccountBalance6=GetObjectReference('frmCommonPage','AccountBalance6');
var objAccountBalance7=GetObjectReference('frmCommonPage','AccountBalance7');
var objAccountBalance8=GetObjectReference('frmCommonPage','AccountBalance8');
var objAccountBalance9=GetObjectReference('frmCommonPage','AccountBalance9');
var objAccountBalance10=GetObjectReference('frmCommonPage','AccountBalance10');
var objAccountBalance11=GetObjectReference('frmCommonPage','AccountBalance11');
var objAccountBalance12=GetObjectReference('frmCommonPage','AccountBalance12');




var valAccountBalance1=0;
var valAccountBalance2=0;
var valAccountBalance3=0;
var valAccountBalance4=0;
var valAccountBalance5=0;
var valAccountBalance6=0;
var valAccountBalance7=0;
var valAccountBalance8=0;
var valAccountBalance9=0;
var valAccountBalance10=0;
var valAccountBalance11=0;
var valAccountBalance12=0;



valAccountBalance1 = evalValue(objBillAmount1.value)-evalValue(objAmountPaid1.value);
valAccountBalance2 = evalValue(objBillAmount2.value)-evalValue(objAmountPaid2.value);
valAccountBalance3 = evalValue(objBillAmount3.value)-evalValue(objAmountPaid3.value);
valAccountBalance4 = evalValue(objBillAmount4.value)-evalValue(objAmountPaid4.value);
valAccountBalance5 = evalValue(objBillAmount5.value)-evalValue(objAmountPaid5.value);
valAccountBalance6 = evalValue(objBillAmount6.value)-evalValue(objAmountPaid6.value);
valAccountBalance7 = evalValue(objBillAmount7.value)-evalValue(objAmountPaid7.value);
valAccountBalance8 = evalValue(objBillAmount8.value)-evalValue(objAmountPaid8.value);
valAccountBalance9 = evalValue(objBillAmount9.value)-evalValue(objAmountPaid9.value);
valAccountBalance10 = evalValue(objBillAmount10.value)-evalValue(objAmountPaid10.value);
valAccountBalance11 = evalValue(objBillAmount11.value)-evalValue(objAmountPaid11.value);
valAccountBalance12 = evalValue(objBillAmount12.value)-evalValue(objAmountPaid12.value);

 objAccountBalance1.value = valAccountBalance1.toFixed(2);
 objAccountBalance2.value = valAccountBalance2.toFixed(2);
 objAccountBalance3.value = valAccountBalance3.toFixed(2);
 objAccountBalance4.value = valAccountBalance4.toFixed(2);
 objAccountBalance5.value = valAccountBalance5.toFixed(2);
 objAccountBalance6.value = valAccountBalance6.toFixed(2);
 objAccountBalance7.value = valAccountBalance7.toFixed(2);
 objAccountBalance8.value = valAccountBalance8.toFixed(2);
 objAccountBalance9.value = valAccountBalance9.toFixed(2);
 objAccountBalance10.value = valAccountBalance10.toFixed(2);
 objAccountBalance11.value = valAccountBalance11.toFixed(2);
 objAccountBalance12.value = valAccountBalance12.toFixed(2);




if (!formatValue(objAccountBalance1)) return;
if (!formatValue(objAccountBalance2)) return;
if (!formatValue(objAccountBalance3)) return;
if (!formatValue(objAccountBalance4)) return;
if (!formatValue(objAccountBalance5)) return;
if (!formatValue(objAccountBalance6)) return;
if (!formatValue(objAccountBalance7)) return;
if (!formatValue(objAccountBalance8)) return;
if (!formatValue(objAccountBalance9)) return;
if (!formatValue(objAccountBalance10)) return;
if (!formatValue(objAccountBalance11)) return;
if (!formatValue(objAccountBalance12)) return;

 
var objTotalBalance=GetObjectReference('frmCommonPage','TotalBalance');
var valTotalBalance;
var valTotalBalance=0;
valTotalBalance =  evalValue(objAccountBalance1.value) + evalValue(objAccountBalance2.value) + evalValue(objAccountBalance3.value) + evalValue(objAccountBalance4.value) + evalValue(objAccountBalance5.value) + evalValue(objAccountBalance6.value) + evalValue(objAccountBalance7.value) + evalValue(objAccountBalance8.value) + evalValue(objAccountBalance9.value) + evalValue(objAccountBalance10.value) + evalValue(objAccountBalance11.value) + evalValue(objAccountBalance12.value);
if (!isNaN(valTotalBalance)) {objTotalBalance.value = valTotalBalance.toFixed(2);}


}




/* ################################################################################################################################################################################## */
/* ################################################################################################################################################################################## */




/*
	Function Name	:	calculateProfitFromSale
	Description		:	Calculate the Profit
	Page	Name	:	Home Inventories Details
*/
function calculateProfitFromSale()
{
var objSalePrice=GetObjectReference('frmCommonPage','SalePrice');
var objPurchasePrice=GetObjectReference('frmCommonPage','PurchasePrice');
var objAppraisalPrice=GetObjectReference('frmCommonPage','AppraisalPrice');
var objProfitFromSale=GetObjectReference('frmCommonPage','ProfitFromSale');
var valProfitFromSale;

if (!formatValue(objSalePrice)) return;
if (!formatValue(objPurchasePrice)) return;
if (!formatValue(objAppraisalPrice)) return;
valProfitFromSale=0;
valProfitFromSale =  evalValue(objSalePrice.value) - (evalValue(objPurchasePrice.value) + evalValue(objAppraisalPrice.value));
if (!isNaN(valProfitFromSale)) {objProfitFromSale.value =valProfitFromSale.toFixed(2);}
}


/* ################################################################################################################################################################################## */
/* ################################################################################################################################################################################## */


/*
	Function Name	:	CalculateExtendedTotal
	Description		:	Calculate the Extended Total
	Page	Name	:	Order Information
*/

function CalculateExtendedTotal()
{
var objQuantity1=GetObjectReference('frmCommonPage','Quantity1');
var objQuantity2=GetObjectReference('frmCommonPage','Quantity2');
var objQuantity3=GetObjectReference('frmCommonPage','Quantity3');
var objQuantity4=GetObjectReference('frmCommonPage','Quantity4');
var objQuantity5=GetObjectReference('frmCommonPage','Quantity5');
var objQuantity6=GetObjectReference('frmCommonPage','Quantity6');
var objQuantity7=GetObjectReference('frmCommonPage','Quantity7');
var objQuantity8=GetObjectReference('frmCommonPage','Quantity8');
var objQuantity9=GetObjectReference('frmCommonPage','Quantity9');
var objQuantity10=GetObjectReference('frmCommonPage','Quantity10');




var objPrice1=GetObjectReference('frmCommonPage','Price1');
var objPrice2=GetObjectReference('frmCommonPage','Price2');
var objPrice3=GetObjectReference('frmCommonPage','Price3');
var objPrice4=GetObjectReference('frmCommonPage','Price4');
var objPrice5=GetObjectReference('frmCommonPage','Price5');
var objPrice6=GetObjectReference('frmCommonPage','Price6');
var objPrice7=GetObjectReference('frmCommonPage','Price7');
var objPrice8=GetObjectReference('frmCommonPage','Price8');
var objPrice9=GetObjectReference('frmCommonPage','Price9');
var objPrice10=GetObjectReference('frmCommonPage','Price10');
var objShipping=GetObjectReference('frmCommonPage','Shipping');
var objTax=GetObjectReference('frmCommonPage','Tax');


var objExtendedPrice1=GetObjectReference('frmCommonPage','ExtendedPrice1');
var objExtendedPrice2=GetObjectReference('frmCommonPage','ExtendedPrice2');
var objExtendedPrice3=GetObjectReference('frmCommonPage','ExtendedPrice3');
var objExtendedPrice4=GetObjectReference('frmCommonPage','ExtendedPrice4');
var objExtendedPrice5=GetObjectReference('frmCommonPage','ExtendedPrice5');
var objExtendedPrice6=GetObjectReference('frmCommonPage','ExtendedPrice6');
var objExtendedPrice7=GetObjectReference('frmCommonPage','ExtendedPrice7');
var objExtendedPrice8=GetObjectReference('frmCommonPage','ExtendedPrice8');
var objExtendedPrice9=GetObjectReference('frmCommonPage','ExtendedPrice9');
var objExtendedPrice10=GetObjectReference('frmCommonPage','ExtendedPrice10');


var valExtendedPrice1=0;
var valExtendedPrice2=0;
var valExtendedPrice3=0;
var valExtendedPrice4=0;
var valExtendedPrice5=0;
var valExtendedPrice6=0;
var valExtendedPrice7=0;
var valExtendedPrice8=0;
var valExtendedPrice9=0;
var valExtendedPrice10=0;


valExtendedPrice1 = evalValue(objPrice1.value)*evalValue(objQuantity1.value);
valExtendedPrice2 = evalValue(objPrice2.value)*evalValue(objQuantity2.value);
valExtendedPrice3 = evalValue(objPrice3.value)*evalValue(objQuantity3.value);
valExtendedPrice4 = evalValue(objPrice4.value)*evalValue(objQuantity4.value);
valExtendedPrice5 = evalValue(objPrice5.value)*evalValue(objQuantity5.value);
valExtendedPrice6 = evalValue(objPrice6.value)*evalValue(objQuantity6.value);
valExtendedPrice7 = evalValue(objPrice7.value)*evalValue(objQuantity7.value);
valExtendedPrice8 = evalValue(objPrice8.value)*evalValue(objQuantity8.value);
valExtendedPrice9 = evalValue(objPrice9.value)*evalValue(objQuantity9.value);
valExtendedPrice10 = evalValue(objPrice10.value)*evalValue(objQuantity10.value);

 objExtendedPrice1.value = valExtendedPrice1.toFixed(2);
 objExtendedPrice2.value = valExtendedPrice2.toFixed(2);
 objExtendedPrice3.value = valExtendedPrice3.toFixed(2);
 objExtendedPrice4.value = valExtendedPrice4.toFixed(2);
 objExtendedPrice5.value = valExtendedPrice5.toFixed(2);
 objExtendedPrice6.value = valExtendedPrice6.toFixed(2);
 objExtendedPrice7.value = valExtendedPrice7.toFixed(2);
 objExtendedPrice8.value = valExtendedPrice8.toFixed(2);
 objExtendedPrice9.value = valExtendedPrice9.toFixed(2);
 objExtendedPrice10.value = valExtendedPrice10.toFixed(2);

 
if (!formatValue(objPrice1)) return;
if (!formatValue(objPrice2)) return;
if (!formatValue(objPrice3)) return;
if (!formatValue(objPrice4)) return;
if (!formatValue(objPrice5)) return;
if (!formatValue(objPrice6)) return;
if (!formatValue(objPrice7)) return;
if (!formatValue(objPrice8)) return;
if (!formatValue(objPrice9)) return;
if (!formatValue(objPrice10)) return;


if (!formatValue(objExtendedPrice1)) return;
if (!formatValue(objExtendedPrice2)) return;
if (!formatValue(objExtendedPrice3)) return;
if (!formatValue(objExtendedPrice4)) return;
if (!formatValue(objExtendedPrice5)) return;
if (!formatValue(objExtendedPrice6)) return;
if (!formatValue(objExtendedPrice7)) return;
if (!formatValue(objExtendedPrice8)) return;
if (!formatValue(objExtendedPrice9)) return;
if (!formatValue(objExtendedPrice10)) return;



if (!formatValue(objQuantity1)) return;
if (!formatValue(objQuantity2)) return;
if (!formatValue(objQuantity3)) return;
if (!formatValue(objQuantity4)) return;
if (!formatValue(objQuantity5)) return;
if (!formatValue(objQuantity6)) return;
if (!formatValue(objQuantity7)) return;
if (!formatValue(objQuantity8)) return;
if (!formatValue(objQuantity9)) return;
if (!formatValue(objQuantity10)) return;


if (!formatValue(objShipping)) return;    
if (!formatValue(objTax)) return;       
 
var objTotal=GetObjectReference('frmCommonPage','Total');
var valTotal=0;

valTotal =  evalValue(objExtendedPrice1.value) + evalValue(objExtendedPrice2.value) + evalValue(objExtendedPrice3.value) + evalValue(objExtendedPrice4.value) + evalValue(objExtendedPrice5.value) + evalValue(objExtendedPrice6.value) + evalValue(objExtendedPrice7.value) + evalValue(objExtendedPrice8.value) + evalValue(objExtendedPrice9.value) + evalValue(objExtendedPrice10.value) + evalValue(objTax.value) + evalValue(objShipping.value);
if (!isNaN(valTotal)) {objTotal.value = valTotal.toFixed(2);}


}









/*
	Function Name	:	calculateTotalCalories
	Description		:	Calculate the Total Calories
	Page	Name	:	Diet Tracker
*/
function calculateTotalCalories()
{
var objC1=GetObjectReference('frmCommonPage','C1');
var objC2=GetObjectReference('frmCommonPage','C2');
var objC3=GetObjectReference('frmCommonPage','C3');
var objC4=GetObjectReference('frmCommonPage','C4');
var objC5=GetObjectReference('frmCommonPage','C5');
var objC6=GetObjectReference('frmCommonPage','C6');
var objC7=GetObjectReference('frmCommonPage','C7');
var objC8=GetObjectReference('frmCommonPage','C8');
var objC9=GetObjectReference('frmCommonPage','C9');
var objC10=GetObjectReference('frmCommonPage','C10');
var objC11=GetObjectReference('frmCommonPage','C11');
var objC12=GetObjectReference('frmCommonPage','C12');
var objC13=GetObjectReference('frmCommonPage','C13');
var objC14=GetObjectReference('frmCommonPage','C14');
var objC15=GetObjectReference('frmCommonPage','C15');

var objTotalCalories=GetObjectReference('frmCommonPage','TotalCalories');
var valTotalCalories;



if (!formatValue(objC1)) return;
if (!formatValue(objC2)) return;
if (!formatValue(objC3)) return;
if (!formatValue(objC4)) return;
if (!formatValue(objC5)) return;
if (!formatValue(objC6)) return;
if (!formatValue(objC7)) return;
if (!formatValue(objC8)) return;
if (!formatValue(objC9)) return;
if (!formatValue(objC10)) return;
if (!formatValue(objC11)) return;
if (!formatValue(objC12)) return;
if (!formatValue(objC13)) return;
if (!formatValue(objC14)) return;
if (!formatValue(objC15)) return;



valTotalCalories=0;
valTotalCalories =  evalValue(objC1.value) + evalValue(objC2.value) + evalValue(objC3.value) + evalValue(objC4.value) + evalValue(objC5.value) + evalValue(objC6.value) + evalValue(objC7.value) + evalValue(objC8.value) + evalValue(objC9.value) + evalValue(objC10.value) + evalValue(objC11.value) + evalValue(objC12.value) + evalValue(objC13.value) + evalValue(objC14.value) + evalValue(objC15.value);
if (!isNaN(valTotalCalories)) {objTotalCalories.value = valTotalCalories.toFixed(2);}


}





/* ################################################################################################################################################################################## */
/* ################################################################################################################################################################################## */





/*
	Function Name	:	calculateTotal()
	Description	    :	Calculate the Total Amount
	Page	Name	:	Invoice Details	
*/
function calculateTotal()
{
var objPrice1=GetObjectReference('frmCommonPage','Price1');
var objPrice2=GetObjectReference('frmCommonPage','Price2');
var objPrice3=GetObjectReference('frmCommonPage','Price3');
var objPrice4=GetObjectReference('frmCommonPage','Price4');
var objPrice5=GetObjectReference('frmCommonPage','Price5');
var objSubTotal=GetObjectReference('frmCommonPage','SubTotal');
//var objSubTotal=GetObjectReference('frmCommonPage','SubTotal');
var objTax=GetObjectReference('frmCommonPage','Tax');
var objShipping=GetObjectReference('frmCommonPage','Shipping');
var objTotal=GetObjectReference('frmCommonPage','Total');
var valSubTotal;
var valTotal;
var valTax=0;

if (!formatValue(objPrice1)) return;
if (!formatValue(objPrice2)) return;
if (!formatValue(objPrice3)) return;
if (!formatValue(objPrice4)) return;
if (!formatValue(objPrice5)) return;
//if (!formatValue(objSubTotal)) return;
if (!formatValue(objTax)) return;
if (!formatValue(objShipping)) return;


valSubTotal=0;
valTotal=0;
valSubTotal =  evalValue(objPrice1.value) + evalValue(objPrice2.value) + evalValue(objPrice3.value) + evalValue(objPrice4.value) + evalValue(objPrice5.value);
if (!isNaN(valSubTotal)) {objSubTotal.value =valSubTotal.toFixed(2);}
valTax = evalValue(objTax.value);

valTotal =  (valSubTotal) + (valTax ) + evalValue(objShipping.value);
if (!isNaN(valTotal)) {objTotal.value =valTotal.toFixed(2);}
}


/* ################################################################################################################################################################################## */
/* ################################################################################################################################################################################## */



/*
	Function Name	:	CalculateGrandTotal()
	Description	    :	Calculate the Sub Total Amount
	Page	Name	:	Purchase Order
*/

function CalculateGrandTotal()
{
var objQuantity1=GetObjectReference('frmCommonPage','Quantity1');
var objQuantity2=GetObjectReference('frmCommonPage','Quantity2');
var objQuantity3=GetObjectReference('frmCommonPage','Quantity3');
var objQuantity4=GetObjectReference('frmCommonPage','Quantity4');
var objQuantity5=GetObjectReference('frmCommonPage','Quantity5');
var objQuantity6=GetObjectReference('frmCommonPage','Quantity6');
var objQuantity7=GetObjectReference('frmCommonPage','Quantity7');
var objQuantity8=GetObjectReference('frmCommonPage','Quantity8');
var objQuantity9=GetObjectReference('frmCommonPage','Quantity9');
var objQuantity10=GetObjectReference('frmCommonPage','Quantity10');

var objTotal1=GetObjectReference('frmCommonPage','Total1');
var objTotal2=GetObjectReference('frmCommonPage','Total2');
var objTotal3=GetObjectReference('frmCommonPage','Total3');
var objTotal4=GetObjectReference('frmCommonPage','Total4');
var objTotal5=GetObjectReference('frmCommonPage','Total5');
var objTotal6=GetObjectReference('frmCommonPage','Total6');
var objTotal7=GetObjectReference('frmCommonPage','Total7');
var objTotal8=GetObjectReference('frmCommonPage','Total8');
var objTotal9=GetObjectReference('frmCommonPage','Total9');
var objTotal10=GetObjectReference('frmCommonPage','Total10');


var objPrice1=GetObjectReference('frmCommonPage','Price1');
var objPrice2=GetObjectReference('frmCommonPage','Price2');
var objPrice3=GetObjectReference('frmCommonPage','Price3');
var objPrice4=GetObjectReference('frmCommonPage','Price4');
var objPrice5=GetObjectReference('frmCommonPage','Price5');
var objPrice6=GetObjectReference('frmCommonPage','Price6');
var objPrice7=GetObjectReference('frmCommonPage','Price7');
var objPrice8=GetObjectReference('frmCommonPage','Price8');
var objPrice9=GetObjectReference('frmCommonPage','Price9');
var objPrice10=GetObjectReference('frmCommonPage','Price10');

var objDiscount1=GetObjectReference('frmCommonPage','Discount1');
var objDiscount2=GetObjectReference('frmCommonPage','Discount2');
var objDiscount3=GetObjectReference('frmCommonPage','Discount3');
var objDiscount4=GetObjectReference('frmCommonPage','Discount4');
var objDiscount5=GetObjectReference('frmCommonPage','Discount5');
var objDiscount6=GetObjectReference('frmCommonPage','Discount6');
var objDiscount7=GetObjectReference('frmCommonPage','Discount7');
var objDiscount8=GetObjectReference('frmCommonPage','Discount8');
var objDiscount9=GetObjectReference('frmCommonPage','Discount9');
var objDiscount10=GetObjectReference('frmCommonPage','Discount10');

var objTaxRate= GetObjectReference('frmCommonPage','TaxRate');
var objSubTotal=GetObjectReference('frmCommonPage','SubTotal');
var objShipping=GetObjectReference('frmCommonPage','Shipping');
var objTax=GetObjectReference('frmCommonPage','Tax');
var objGrandTotal=GetObjectReference('frmCommonPage','GrandTotal');
var objPurchaseOrderAmount=GetObjectReference('frmCommonPage','PurchaseOrderAmount');




var valTotal1=0;
var valTotal2=0;
var valTotal3=0;
var valTotal4=0;
var valTotal5=0;
var valTotal6=0;
var valTotal7=0;
var valTotal8=0;
var valTotal9=0;
var valTotal10=0;

var valSubTotal=0;
var valShipping=0;
var valGrandTotal=0;
var valTaxRate=0;
var valTax=0;


if (!formatValue(objPrice1)) return;
if (!formatValue(objPrice2)) return;
if (!formatValue(objPrice3)) return;
if (!formatValue(objPrice4)) return;
if (!formatValue(objPrice5)) return;
if (!formatValue(objPrice6)) return;
if (!formatValue(objPrice7)) return;
if (!formatValue(objPrice8)) return;
if (!formatValue(objPrice9)) return;
if (!formatValue(objPrice10)) return;

if (!formatValue(objDiscount1)) return;
if (!formatValue(objDiscount2)) return;
if (!formatValue(objDiscount3)) return;
if (!formatValue(objDiscount4)) return;
if (!formatValue(objDiscount5)) return;
if (!formatValue(objDiscount6)) return;
if (!formatValue(objDiscount7)) return;
if (!formatValue(objDiscount8)) return;
if (!formatValue(objDiscount9)) return;
if (!formatValue(objDiscount10)) return;

valTotal1 = (evalValue(objPrice1.value)*evalValue(objQuantity1.value))- evalValue(objDiscount1.value);
valTotal2 = (evalValue(objPrice2.value)*evalValue(objQuantity2.value))- evalValue(objDiscount2.value);
valTotal3 = (evalValue(objPrice3.value)*evalValue(objQuantity3.value))- evalValue(objDiscount3.value);
valTotal4 = (evalValue(objPrice4.value)*evalValue(objQuantity4.value))- evalValue(objDiscount4.value);
valTotal5 = (evalValue(objPrice5.value)*evalValue(objQuantity5.value))- evalValue(objDiscount5.value);
valTotal6 = (evalValue(objPrice6.value)*evalValue(objQuantity6.value))- evalValue(objDiscount6.value);
valTotal7 = (evalValue(objPrice7.value)*evalValue(objQuantity7.value))- evalValue(objDiscount7.value);
valTotal8 = (evalValue(objPrice8.value)*evalValue(objQuantity8.value))- evalValue(objDiscount8.value);
valTotal9 = (evalValue(objPrice9.value)*evalValue(objQuantity9.value))- evalValue(objDiscount9.value);
valTotal10 = (evalValue(objPrice10.value)*evalValue(objQuantity10.value))- evalValue(objDiscount10.value);

 if (!isNaN(valTotal1)) { objTotal1.value = valTotal1.toFixed(2);}
 if (!isNaN(valTotal2)) { objTotal2.value = valTotal2.toFixed(2);}
 if (!isNaN(valTotal3)) { objTotal3.value = valTotal3.toFixed(2);}
 if (!isNaN(valTotal4)) { objTotal4.value = valTotal4.toFixed(2);}
 if (!isNaN(valTotal5)) { objTotal5.value = valTotal5.toFixed(2);}
 if (!isNaN(valTotal6)) { objTotal6.value = valTotal6.toFixed(2);}
 if (!isNaN(valTotal7)) { objTotal7.value = valTotal7.toFixed(2);}
 if (!isNaN(valTotal8)) { objTotal8.value = valTotal8.toFixed(2);}
 if (!isNaN(valTotal9)) { objTotal9.value = valTotal9.toFixed(2);}
 if (!isNaN(valTotal10)) { objTotal10.value = valTotal10.toFixed(2);}

valSubTotal=evalValue(objTotal1.value) + evalValue(objTotal2.value) + evalValue(objTotal3.value) + evalValue(objTotal4.value) + evalValue(objTotal5.value) + evalValue(objTotal6.value) + evalValue(objTotal7.value) + evalValue(objTotal8.value) + evalValue(objTotal9.value) + evalValue(objTotal10.value);
if (!isNaN(valSubTotal)) {objSubTotal.value = valSubTotal.toFixed(2);}

 valTaxRate = objTaxRate.value;

objTax.value = (evalValue(objSubTotal.value)*valTaxRate)/100;
if (!formatValue(objTax)) return;
valTax =  objTax.value;


valShipping = (objShipping.value);
if (!formatValue(objShipping)) return;

var valGrandTotal=0;
valGrandTotal= evalValue(objSubTotal.value)+evalValue(objTax.value)+evalValue(objShipping.value);
if (!isNaN(valGrandTotal)) {objGrandTotal.value = valGrandTotal.toFixed(2);}
if (!formatValue(objGrandTotal)) return;

objPurchaseOrderAmount.value = objGrandTotal.value
if (!formatValue(objPurchaseOrderAmount)) return;



}





/*
	Function Name	:	calculateSubTotal()
	Description	    :	Calculate the SubTotal Amount
	Page	Name	:	Invoice Details	
*/
/*
function calculateSubTotal()
{
var objPrice1=GetObjectReference('frmCommonPage','Price1');
var objPrice2=GetObjectReference('frmCommonPage','Price2');
var objPrice3=GetObjectReference('frmCommonPage','Price3');
var objPrice4=GetObjectReference('frmCommonPage','Price4');
var objPrice5=GetObjectReference('frmCommonPage','Price5');
var objSubTotal=GetObjectReference('frmCommonPage','SubTotal');
var valSubTotal;


if (!formatValue(objPrice1)) return;
if (!formatValue(objPrice2)) return;
if (!formatValue(objPrice3)) return;
if (!formatValue(objPrice4)) return;
if (!formatValue(objPrice5)) return;

valSubTotal=0;

valSubTotal =  evalValue(objPrice1.value) + evalValue(objPrice2.value) + evalValue(objPrice3.value) + evalValue(objPrice4.value) + evalValue(objPrice5.value);
if (!isNaN(valSubTotal)) {objSubTotal.value =valSubTotal.toFixed(2);}
}
*/

/*
	Function Name	:	calculateTotal()
	Description	    :	Calculate the Total Amount
	Page	Name	:	Invoice Details	
*/

/*
function calculateTotal()
{
var objSubTotal=GetObjectReference('frmCommonPage','SubTotal');
var objTax=GetObjectReference('frmCommonPage','Tax');
var objShipping=GetObjectReference('frmCommonPage','Shipping');
var objTotal=GetObjectReference('frmCommonPage','Total');
var valTotal;

if (!formatValue(objTax)) return;
if (!formatValue(objShipping)) return;

valTotal=0;


valTotal = objSubTotal + evalValue(objTax.value) + evalValue(objShipping.value);
if (!isNaN(valTotal)) {objTotal.value =valTotal.toFixed(2);}
}*/


/*-------------------------------------------------------------------------------------------------------*/

/*
	Function Name	:	RoundUp()
	Description	    :	RoundUp the  Amounts
	Page	Name	:	Employee Records
*/

function RoundUp()
{
var objSalary=GetObjectReference('frmCommonPage','Salary');
var objHourlyRate=GetObjectReference('frmCommonPage','HourlyRate');
var objHoursPerWeek=GetObjectReference('frmCommonPage','HoursPerWeek');
var objCommission=GetObjectReference('frmCommonPage','Commission');

if (!formatValue(objSalary)) return;
if (!formatValue(objHourlyRate)) return;
if (!formatValue(objHoursPerWeek)) return;
if (!formatValue(objCommission)) return;

}


function MembershipRoundUp()
{
var objDuesAmount=GetObjectReference('frmCommonPage','DuesAmount');
if (!formatValue(objDuesAmount)) return;
}


function PatientRoundUp()
{
var objCoPayAmount=GetObjectReference('frmCommonPage','CoPayAmount');
if (!formatValue(objCoPayAmount)) return;
}


function InventoryRoundUp()
{
var objCost=GetObjectReference('frmCommonPage','Cost');
if (!formatValue(objCost)) return;
}



function BookCollectionRoundUp()
{
var objPrice=GetObjectReference('frmCommonPage','Price');
if (!formatValue(objPrice)) return;
}



/*
	Function Name	:	PropertyListingRoundUp()
	Description	    :	RoundUp the  Amounts
	Page	Name	:	Property Listing
*/

function PropertyListingRoundUp()
{
var objListPrice=GetObjectReference('frmCommonPage','ListPrice');
var objSaleRentalPrice=GetObjectReference('frmCommonPage','SaleRentalPrice');
var objSquareFt=GetObjectReference('frmCommonPage','SquareFt');

if (!formatValue(objListPrice)) return;
if (!formatValue(objSaleRentalPrice)) return;
if (!formatValue(objSquareFt)) return;
}


/*
	Function Name	:	JobListingRoundUp()
	Description	    :	RoundUp the  Amounts
	Page	Name	:	Job Listing
*/

function JobListingRoundUp()
{
var objSalary=GetObjectReference('frmCommonPage','Salary');
var objSignOnBonus=GetObjectReference('frmCommonPage','SignOnBonus');
var objSignOnBonusGiven=GetObjectReference('frmCommonPage','SignOnBonusGiven');

if (!formatValue(objSalary)) return;
if (!formatValue(objSignOnBonus)) return;
if (!formatValue(objSignOnBonusGiven)) return;
}
