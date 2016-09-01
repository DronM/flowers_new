<?php
require_once(FRAME_WORK_PATH.'basic_classes/Model.php');

class MainMenu_Model_cashier extends Model{
	public function dataToXML(){
		return '<model id="MainMenu_Model">
		
<menuItem

descr="Продажи"

>
<menuItem

viewId="SaleProduct_View"

descr="Текущая продажа"

default="TRUE"

></menuItem>

<menuItem

viewId="DOCSaleList_View"

descr="Журнал документов"

></menuItem>

<menuItem

viewId="ProductBalanceList_View"

descr="Остатки"

></menuItem>

<menuItem

viewId="CashRegisterOper_View"

descr="ККМ"

></menuItem>
</menuItem>

<menuItem

descr="Администрирование"

>
<menuItem

viewId="UserNewPassword_View"

descr="Сменить свой пароль"

></menuItem>
</menuItem>

		</model>';
	}
}
?>
