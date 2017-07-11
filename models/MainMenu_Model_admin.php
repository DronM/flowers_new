<?php
require_once(FRAME_WORK_PATH.'basic_classes/Model.php');

class MainMenu_Model_admin extends Model{
	public function dataToXML(){
		return '<model id="MainMenu_Model">
		
<menuItem

descr="Справочники"

>
<menuItem

descr="Салоны"

default="FALSE"

c="Store_Controller"

f="get_list"

t="StoreList"

></menuItem>

<menuItem

descr="Букеты"

default="FALSE"

c="Product_Controller"

f="get_list"

t="ProductList"

></menuItem>

<menuItem

descr="Группы материалов"

default="FALSE"

c="MaterialGroup_Controller"

f="get_list"

t="MaterialGroup"

></menuItem>

<menuItem

descr="Материалы"

default="FALSE"

c="Material_Controller"

f="get_list"

t="MaterialList"

limit="TRUE"

></menuItem>

<menuItem

descr="Поставщики"

default="FALSE"

c="Supplier_Controller"

f="get_list"

t="SupplierList"

limit="TRUE"

></menuItem>

<menuItem

descr="Покупатели"

default="FALSE"

c="Client_Controller"

f="get_list"

t="ClientList"

limit="TRUE"

></menuItem>

<menuItem

descr="Виды скидок"

default="FALSE"

c="Discount_Controller"

f="get_list"

t="DiscountList"

></menuItem>

<menuItem

descr="Типы оплаты"

default="FALSE"

c="PaymentTypeForSale_Controller"

f="get_list"

t="PaymentTypeForSale"

></menuItem>

<menuItem

descr="ККМ"

default="FALSE"

c="CashRegister_Controller"

f="get_list"

t="CashRegister"

></menuItem>
</menuItem>

<menuItem

descr="Букеты"

>
<menuItem

descr="Остатки"

default="TRUE"

c="Product_Controller"

f="get_list_with_balance"

t="ProductBalanceList"

></menuItem>

<menuItem

descr="Комплектация"

default="FALSE"

c="DOCProduction_Controller"

f="get_list"

t="DOCProductionList"

></menuItem>

<menuItem

descr="Списание"

default="FALSE"

c="DOCProductDisposal_Controller"

f="get_list"

t="DOCProductDisposalList"

></menuItem>
</menuItem>

<menuItem

descr="Материалы"

>
<menuItem

descr="Остатки"

c="Material_Controller"

f="get_list_with_balance"

t="MaterialBalanceList"

></menuItem>

<menuItem

descr="Поступление"

c="DOCMaterialProcurement_Controller"

f="get_list"

t="DOCMaterialProcurementList"

limit="TRUE"

></menuItem>

<menuItem

descr="Списание"

c="DOCMaterialDisposal_Controller"

f="get_list"

t="DOCMaterialDisposalList"

limit="TRUE"

></menuItem>
</menuItem>

<menuItem

descr="Журнал заказов покупателей"

c="DOCClientOrder_Controller"

f="get_list"

t="DOCClientOrderList"

></menuItem>

<menuItem

descr="Журнал продаж"

c="DOCSale_Controller"

f="get_list"

t="DOCSaleList"

limit="TRUE"

></menuItem>

<menuItem

descr="Затраты"

>
<menuItem

descr="Виды затрат"

c="ExpenceType_Controller"

f="get_list"

t="ExpenceType"

></menuItem>

<menuItem

descr="Журнал документов"

c="DOCExpence_Controller"

f="get_list"

t="DOCExpenceList"

></menuItem>

<menuItem

descr="Баланс"

c="RepBalance_Controller"

f="get"

t="RepBalance"

></menuItem>
</menuItem>

<menuItem

descr="Отчеты"

>
<menuItem

descr="Средние цены"

c="Material_Controller"

f="get_object"

t="MaterialProcurAvgPrice"

></menuItem>

<menuItem

descr="Движение материалов"

c="RepMaterialAction_Controller"

f="get_object"

t="MaterialActionsReport"

></menuItem>

<menuItem

descr="Движение мат. (без цен)"

c="RepMaterialAction_Controller"

f="get_object"

t="MaterialActionsNoPriceReport"

></menuItem>

<menuItem

descr="Продажи по материалам"

c="RepSaleForAcc_Controller"

f="get_object"

t="RepSaleForAcc"

></menuItem>

<menuItem

descr="Продажи по видам оплат"

c="RepSalesOnTypes_Controller"

f="get_object"

t="RepSalesOnTypes"

></menuItem>
</menuItem>

<menuItem

descr="Администрирование"

>
<menuItem

descr="Пользователи"

default="FALSE"

c="User_Controller"

f="get_list"

t="UserList"

></menuItem>

<menuItem

descr="Константы"

default="FALSE"

c="Constant_Controller"

f="get_list"

t="ConstantList"

></menuItem>
</menuItem>

		</model>';
	}
}
?>
