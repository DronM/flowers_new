<?php
require_once(FRAME_WORK_PATH.'basic_classes/Model.php');

class MainMenu_Model_admin extends Model{
	public function dataToXML(){
		return '<model id="MainMenu_Model">
		
<menuItem

descr="Справочники"

>
<menuItem

viewId="StoreList_View"

descr="Салоны"

></menuItem>

<menuItem

viewId="ProductList_View"

descr="Букеты"

></menuItem>

<menuItem

viewId="MaterialGroup_View"

descr="Группы материалов"

></menuItem>

<menuItem

viewId="MaterialList_View"

descr="Материалы"

></menuItem>

<menuItem

viewId="SupplierList_View"

descr="Поставщики"

></menuItem>

<menuItem

viewId="ClientList_View"

descr="Покупатели"

></menuItem>

<menuItem

viewId="PaymentTypeForSale_View"

descr="Типы оплаты"

></menuItem>

<menuItem

viewId="CashRegister_View"

descr="ККМ"

></menuItem>
</menuItem>

<menuItem

descr="Заказы покупателей"

>
<menuItem

viewId="DOCClientOrderList_View"

descr="Журнал"

></menuItem>
</menuItem>

<menuItem

descr="Букеты"

>
<menuItem

viewId="ProductBalanceList_View"

descr="Остатки"

default="TRUE"

></menuItem>

<menuItem

viewId="DOCProductionList_View"

descr="Комплектация"

></menuItem>

<menuItem

viewId="DOCProductDisposalList_View"

descr="Списание"

></menuItem>
</menuItem>

<menuItem

descr="Материалы"

>
<menuItem

viewId="MaterialBalanceList_View"

descr="Остатки"

></menuItem>

<menuItem

viewId="DOCMaterialOrderList_View"

descr="Заказы"

></menuItem>

<menuItem

viewId="DOCMaterialProcurementList_View"

descr="Поступление"

></menuItem>

<menuItem

viewId="DOCMaterialDisposalList_View"

descr="Списание"

></menuItem>
</menuItem>

<menuItem

descr="Продажи"

>
<menuItem

viewId="DOCSaleList_View"

descr="Продажи"

></menuItem>
</menuItem>

<menuItem

descr="Затраты"

>
<menuItem

viewId="ExpenceTypeList_View"

descr="Виды затрат"

></menuItem>

<menuItem

viewId="DOCExpenceList_View"

descr="Журнал документов"

></menuItem>

<menuItem

viewId="RepBalance_View"

descr="Баланс"

></menuItem>
</menuItem>

<menuItem

descr="Отчеты"

>
<menuItem

viewId="MaterialProcurAvgPriceReport_View"

descr="Средние цены поступления"

></menuItem>

<menuItem

viewId="MaterialActionsReport_View"

descr="Движение материалов"

></menuItem>

<menuItem

viewId="MaterialActionsNoPriceReport_View"

descr="Движение материалов (без цен)"

></menuItem>

<menuItem

viewId="RepSaleForAcc_View"

descr="Продажи по материалам"

></menuItem>

<menuItem

viewId="RepSalesOnTypes_View"

descr="Продажи по видам оплат"

></menuItem>
</menuItem>

<menuItem

descr="Администрирование"

>
<menuItem

viewId="UserList_View"

descr="Пользователи"

></menuItem>

<menuItem

viewId="ConstantList_View"

descr="Константы"

></menuItem>

<menuItem

viewId="UserNewPassword_View"

descr="Сменить свой пароль"

></menuItem>
</menuItem>

		</model>';
	}
}
?>
