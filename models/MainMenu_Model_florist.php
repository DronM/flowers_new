<?php
require_once(FRAME_WORK_PATH.'basic_classes/Model.php');

class MainMenu_Model_florist extends Model{
	public function dataToXML(){
		return '<model id="MainMenu_Model">
		
<menuItem

descr="Справочники"

>
<menuItem

viewId="MaterialList_View"

descr="Материалы"

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
