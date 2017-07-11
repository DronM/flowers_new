<?php
require_once(FRAME_WORK_PATH.'basic_classes/ViewHTMLXSLT.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelStyleSheet.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelJavaScript.php');

require_once(FRAME_WORK_PATH.'basic_classes/ModelTemplate.php');
require_once(USER_CONTROLLERS_PATH.'Constant_Controller.php');

require_once(USER_MODELS_PATH.'MaterialGroup_Model.php');


			require_once('models/MainMenu_Model_admin.php');
			require_once('models/MainMenu_Model_store_manager.php');			
			require_once('models/MainMenu_Model_florist.php');
			require_once('models/MainMenu_Model_cashier.php');			
		
class ViewBase extends ViewHTMLXSLT {	

	private $dbLink;

	protected function addMenu(&$models){
		if (isset($_SESSION['role_id'])){
			$menu_class = 'MainMenu_Model_'.$_SESSION['role_id'];
			$models['mainMenu'] = new $menu_class();
		}	
	}
	
	protected function initDbLink(){
		if (!$this->dbLink){
			$this->dbLink = new DB_Sql();
			$this->dbLink->persistent=true;
			$this->dbLink->appname = APP_NAME;
			$this->dbLink->technicalemail = TECH_EMAIL;
			$this->dbLink->reporterror = DEBUG;
			$this->dbLink->database= DB_NAME;			
			$this->dbLink->connect(DB_SERVER,DB_USER,DB_PASSWORD,(defined('DB_PORT'))? DB_PORT:NULL);
		}	
	}
	
	protected function addConstants(&$models){
		if (isset($_SESSION['role_id'])){
			$this->initDbLink();
		
			$contr = new Constant_Controller($this->dbLink);
			$list = array('sale_item_cols','def_store','doc_per_page_count','grid_refresh_interval','shift_length_time','shift_start_time','def_material_group','def_payment_type_for_sale','def_client','def_discount');
			$models['ConstantValueList_Model'] = $contr->getConstantValueModel($list);						
			
		}	
	}

	public function __construct($name){
		parent::__construct($name);
		
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'ext/bootstrap-datepicker/bootstrap-datepicker.standalone.min.css'));		
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/bootstrap/dist/css/bootstrap.min.css'));
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/metisMenu/dist/metisMenu.min.css'));
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/dist/css/timeline.css'));
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/dist/css/sb-admin-2.css'));
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/morrisjs/morris.css'));		
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/font-awesome/css/font-awesome.min.css'));						
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'custom-css/style.css'));
		$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'ext/dhtml/dhtmlwindow.css'));
		
		
	
		if (!DEBUG){
			$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'lib.js'));
			$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/jquery-1.12.4/jquery-1.12.4.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/bootstrap-3.3.6/bootstrap.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/bootstrap-datepicker/bootstrap-datepicker.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/bootstrap-datepicker/bootstrap-datepicker.ru.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/Bush-jquery.maskedinput/dist/jquery.maskedinput.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/metisMenu/dist/metisMenu.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/raphael/raphael-min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/morrisjs/morris.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/dist/js/sb-admin-2.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/jshash-2.2/md5-min.js'));			
			$script_id = VERSION;
		}
		else{		
			$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/jquery-1.12.4/jquery-1.12.4.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/bootstrap-3.3.6/bootstrap.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/bootstrap-datepicker/bootstrap-datepicker.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/bootstrap-datepicker/bootstrap-datepicker.ru.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/Bush-jquery.maskedinput/dist/jquery.maskedinput.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/metisMenu/dist/metisMenu.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/raphael/raphael-min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/bower_components/morrisjs/morris.min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/startbootstrap-sb-admin-2-1.0.8/dist/js/sb-admin-2.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/jshash-2.2/md5-min.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/extend.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/App.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/AppWin.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/CommonHelper.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/DOMHelper.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/DateHelper.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/EventHelper.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ConstantManager.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ServConnector.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ServResp.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ServRespXML.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/PublicMethod.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ControllerDb.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelXML.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelJSON.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelObjectXML.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelObjectJSON.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelServRespXML.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelServRespJSON.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/Validator.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorString.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorBool.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorDate.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorDateTime.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorTime.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorInt.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorFloat.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorEnum.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorJSON.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorArray.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/Field.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldString.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldEnum.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldBool.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldDate.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldDateTime.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldTime.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldInt.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldFloat.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldPassword.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldText.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldJSON.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldArray.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelFilter.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/RefType.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/EquipServer.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/DataBinding.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Command.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/CommandBinding.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Control.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/Control.rs_ru.js'));
	}

	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ControlContainer.js'));
	}

	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ControlContainer.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewAjx.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewAjx.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ErrorControl.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Calculator.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/Calculator.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Button.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCtrl.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonEditCtrl.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonEditCtrl.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCalc.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonCalc.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCalendar.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonCalendar.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonClear.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonClear.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCmd.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonExpToExcel.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonExpToExcel.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonExpToPDF.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonExpToPDF.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonOpen.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonOpen.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonInsert.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonInsert.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonPrint.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonPrint.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonPrintList.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonPrintList.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonSelectRef.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonSelectRef.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonToggle.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Label.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Edit.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/Edit.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditString.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditText.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditInt.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditFloat.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditMoney.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPhone.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditEmail.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPercent.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditDate.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditDateTime.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditTime.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPassword.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditCheckBox.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditContainer.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditContainer.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRadioGroup.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRadio.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditSelect.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditSelectRef.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditSelectRef.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditSelectOption.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditSelectOptionRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRadioGroupRef.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditRadioGroupRef.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditCheckSelect.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditCheckSelect.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/PrintObj.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/HiddenKey.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumn.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnBool.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnPhone.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnFloat.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnDate.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnEnum.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCell.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCellHead.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCellFoot.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridHead.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridRow.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridFoot.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridBody.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Grid.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/Grid.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCommands.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmd.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdContainer.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdContainer.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdContainerAjx.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdContainerDOC.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdInsert.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdInsert.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdEdit.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdEdit.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdCopy.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdCopy.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdDelete.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdDelete.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdColManager.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdColManager.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdPrint.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdPrint.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdRefresh.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdRefresh.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdPrintObj.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdSearch.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdSearch.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdExport.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdExport.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdAllCommands.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdAllCommands.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdDOCUnprocess.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdDOCUnprocess.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdDOCShowActs.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdDOCShowActs.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdRowUp.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdRowUp.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdRowDown.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdRowDown.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdFilter.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdFilter.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdFilterView.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdFilterView.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdFilterSave.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdFilterSave.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCmdFilterOpen.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCmdFilterOpen.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewGridColManager.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewGridColManager.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewGridColParam.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewGridColParam.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewGridColVisibility.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewGridColVisibility.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewGridColOrder.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewGridColOrder.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/VariantStorageSaveView.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/VariantStorageSaveView.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/VariantStorageOpenView.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/VariantStorageOpenView.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridAjx.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridAjx.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridAjxDOCT.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCommandsAjx.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCommandsAjx.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCommandsDOC.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCommandsDOC.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridPagination.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridPagination.rs_ru.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridFilter.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridFilter.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPeriodDate.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditPeriodDate.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPeriodDateTime.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonOK.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonOK.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonSave.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonSave.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCancel.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonCancel.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewObjectAjx.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewObjectAjx.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewGridEditInlineAjx.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewGridEditInlineAjx.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewDOC.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewDOC.rs_ru.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowPrint.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/WindowPrint.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowQuestion.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/WindowQuestion.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowSearch.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/WindowSearch.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowForm.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowFormObject.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/WindowFormObject.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowFormModalBS.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/WindowFormModalBS.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowMessage.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCellHeadDOCProcessed.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCellHeadDOCDate.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCellHeadDOCNumber.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/actb.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/actb.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/RepCommands.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/RepCommands.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewReport.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewReport.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/PopUpMenu.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/PopOver.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/PeriodSelect.js'));
	if (
	(isset($_SESSION['locale_id']) && $_SESSION['locale_id']=='ru')
	||
	(!isset($_SESSION['locale_id']) && DEF_LOCALE=='ru')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/PeriodSelect.rs_ru.js'));
	}
$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Constant_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Enum_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/MaterialGroup_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Material_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Product_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Specification_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Store_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Supplier_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/User_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialDisposal_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialDisposalDOCTMaterial_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialProcurement_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialProcurementDOCTMaterial_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProductDisposal_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProduction_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProductionDOCTMaterial_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCSale_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCSaleDOCTProduct_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCSaleDOCTMaterial_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Receipt_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/ExpenceType_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCExpence_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCExpenceDOCTExpenceType_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/RepBalance_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/RepSaleForAcc_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCClientOrder_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCClientOrderDOCTMaterial_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCClientOrderDOCTProduct_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DeliveryHour_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/CashRegister_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/PaymentTypeForSale_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Client_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/RepSalesOnTypes_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/App.templates.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/AppFlowers.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/MaterialGroupSelect.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/StoreSelect.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/MaterialNameEdit.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/ProductNameEdit.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/SupplierNameEdit.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/ClientNameEdit.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/ClientEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/UserNameEdit.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/CashRegisterSelect.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/PaymentTypeForSaleSelect.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DeliveryHourSelect.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/UserEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/GridColumnCustomTime.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/MaterialGroupRadio.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/SupplierEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/ProductEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCNumberEdit.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCDateEdit.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/MaterialEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCCommands.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCProductionDetMatSysCell.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCSaleReceiptSysCell.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCProductionEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/ExpenceTypeEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DiscountSelect.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DiscCardEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCSaleReceiptEditCell.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/ItemsForSaleGrid.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCClientOrderEditRef.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCSalePayTypeSysCell.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCSalePayTypeEditCell.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/ReceiptPayTypeAddBtn.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/SeqMaterialText.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/ConstantGrid.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/DOCClientOrderGridCommand.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_delivery_note_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_delivery_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_payment_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_client_order_states.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom/rs_ru.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/Material_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/MaterialList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/MaterialBalanceList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/ProductBalanceList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/Supplier_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/Client_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/ClientList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/Product_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/User_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCProduction_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCProductionList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCProductDisposal_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/UserList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/SupplierList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/ProductList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCSale_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCExpence_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCMaterialProcurement_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCMaterialDisposal_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/ExpenceTypeList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCExpence_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DiscCard_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCClientOrder_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCClientOrderList_Form.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/Login_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/StoreList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ProductList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialGroup_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/SupplierList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ClientList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/UserList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/PaymentTypeForSale_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/CashRegister_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/Material_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/Product_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/Supplier_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ClientDialog_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/UserDialog_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ConstantList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialBalanceList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ProductBalanceList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCProductionList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCProductDisposalList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCMaterialDisposalList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCMaterialDisposal_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCProductDisposal_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCMaterialProcurementList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCMaterialProcurement_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCMaterialProcurementDOCTMaterialInline_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCSaleList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ExpenceType_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCExpenceList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/UserProfile_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCProduction_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/QuantEdit_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCExpenceList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCExpence_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/RepBalance_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialProcurAvgPrice_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialActionsReport_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialActionsNoPriceReport_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/RepSaleForAcc_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/RepSalesOnTypes_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCSale_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCSaleDOCTMaterialInline_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCSaleDOCTProductInline_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/CashRegisterOper_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCSaleCashier_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCSaleReceipt_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DiscountList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DiscCard_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ExpenceTypeList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCClientOrderList_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCClientOrder_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCClientOrderDOCTMaterialInline_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCClientOrderDOCTProductInline_View.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/rs_ru.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/FileStorageSmall_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Store_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/StoreList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ConstantList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/User_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/UserList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/UserDialog_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/CashRegister_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Client_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ClientList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ClientDialog_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Product_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ProductBalanceList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MaterialGroup_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Material_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MaterialBalanceList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Supplier_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/SupplierList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Specification_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/SpecificationList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/PaymentTypeForSale_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProduction_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposal_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurement_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrder_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposal_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrder_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTFProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTFProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSale_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDialog_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTFProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTFProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Receipt_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ReceiptList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RGMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RAMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RGProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RAProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/VariantStorage_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/VariantStorageList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RepMaterialAction_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ExpenceType_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpence_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceExpenceTypeList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceDOCTExpenceType_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceDOCTExpenceTypeList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceDOCTFExpenceType_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceDOCTFExpenceTypeList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RepBalance_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DeliveryHour_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DeliveryHourList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Message_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MessageRecipient_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MessageView_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Message_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MessageHeaderList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_role_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_doc_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_reg_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_payment_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_report_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_delivery_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_recipient_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_delivery_note_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_client_order_states.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_message_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/TemplateParam_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_def_date_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/UserProfile_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/TemplateParam_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/TemplateParamVal_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/TemplateParamValList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Discount_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Discount_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DiscountList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DiscCard_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DiscCard_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCManager_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCReprocessStat_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Constant_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ReceiptHead_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ReceiptHeadList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSalePaymentType_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ReceiptPaymentType_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ReceiptPaymentTypeList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/Enum_doc_sequences.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCReprocessStatList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/RepMaterialAction_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_role_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_doc_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_reg_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_report_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_recipient_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_message_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_def_date_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_doc_sequences.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/VariantStorage_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_role_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_doc_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_reg_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_report_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_recipient_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_message_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_def_date_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'enum_controls/EnumGridColumn_doc_sequences.js'));			
			//$script_id = md5(time());
			if (isset($_SESSION['scriptId'])){
				$script_id = $_SESSION['scriptId'];
			}
			else{
				$script_id = VERSION;
			}
		}
		
		
		$this->getVarModel()->addField(new Field('def_store_id',DT_STRING));
		$this->getVarModel()->addField(new Field('constrain_to_store',DT_STRING));
		$this->getVarModel()->addField(new Field('role_id',DT_INT));
		$this->getVarModel()->addField(new Field('cash_reg_id',DT_STRING));
		$this->getVarModel()->addField(new Field('cash_reg_server',DT_STRING));
		$this->getVarModel()->addField(new Field('cash_reg_port',DT_STRING));
		$this->getVarModel()->addField(new Field('multy_store',DT_STRING));
	
		
		$this->getVarModel()->insert();
		$this->setVarValue('scriptId',$script_id);
		$this->setVarValue('basePath',BASE_PATH);
		$this->setVarValue('version',VERSION);		
		$this->setVarValue('debug',DEBUG);				
		if (isset($_SESSION['locale_id'])){
			$this->setVarValue('locale_id',$_SESSION['locale_id']);
		}
		else if (!isset($_SESSION['locale_id']) && defined('DEF_LOCALE')){
			$this->setVarValue('locale_id', DEF_LOCALE);
		}

		
		if (isset($_SESSION['constrain_to_store'])){
			$this->setVarValue('constrain_to_store',$_SESSION['constrain_to_store']);
		}
		if (isset($_SESSION['def_store_id'])){
			$this->setVarValue('def_store_id',$_SESSION['def_store_id']);
		}
		if (isset($_SESSION['role_id'])){
			$this->setVarValue('role_id',$_SESSION['role_id']);
		}
		if (isset($_SESSION['cash_reg_id'])){
			$this->setVarValue('cash_reg_id',$_SESSION['cash_reg_id']);
			$this->setVarValue('cash_reg_server',$_SESSION['cash_reg_server']);
			$this->setVarValue('cash_reg_port',$_SESSION['cash_reg_port']);
		}
		if (isset($_SESSION['multy_store'])){
			$this->setVarValue('multy_store',$_SESSION['multy_store']);
		}
	
		//Global Filters
		
	}
	public function write(ArrayObject &$models){
		$this->addMenu($models);
		
		
		 
		$this->addConstants($models);
		
		//Для динамического формирования меню
		if (isset($_SESSION['role_id']) && $_SESSION['role_id']=='cashier'){
			$this->initDbLink();
			$models['MenuMaterialGroup_Model'] = new MaterialGroup_Model($this->dbLink);
			$models['MenuMaterialGroup_Model']->setId('MenuMaterialGroup_Model');
			$models['MenuMaterialGroup_Model']->select(false,null,null,
				null,null,null,null,null,TRUE);
		}
		
		parent::write($models);
	}	
}	
?>