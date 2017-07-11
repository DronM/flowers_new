<?php
require_once(FRAME_WORK_PATH.'basic_classes/Model.php');

class MainMenu_Model_florist extends Model{
	public function dataToXML(){
		return '<model id="MainMenu_Model">
		
<menuItem

descr="Справочники"

>
<menuItem

descr="Материалы"

default="FALSE"

c="Material_Controller"

f="get_list"

t="MaterialList"

limit="TRUE"

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

		</model>';
	}
}
?>
