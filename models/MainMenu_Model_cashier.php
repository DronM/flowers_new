<?php
require_once(FRAME_WORK_PATH.'basic_classes/Model.php');

class MainMenu_Model_cashier extends Model{
	public function dataToXML(){
		return '<model id="MainMenu_Model">
		
<menuItem

descr="Журнал продаж"

c="DOCSale_Controller"

f="get_list"

t="DOCSaleList"

limit="TRUE"

></menuItem>

<menuItem

descr="Остатки"

>
<menuItem

descr="Остатки букетов"

c="Product_Controller"

f="get_list_with_balance"

t="ProductBalanceList"

></menuItem>

<menuItem

descr="Остатки материалов"

c="Material_Controller"

f="get_list_with_balance"

t="MaterialBalanceList"

></menuItem>
</menuItem>

<menuItem

descr="Заказы покупателей"

c="DOCClientOrder_Controller"

f="get_list"

t="DOCClientOrderList"

></menuItem>

<menuItem

descr="Операции с ККМ"

t="CashRegisterOper"

></menuItem>

		</model>';
	}
}
?>
