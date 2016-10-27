<?php
require_once(FRAME_WORK_PATH.'basic_classes/ViewHTMLXSLT.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelStyleSheet.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelJavaScript.php');

require_once(FRAME_WORK_PATH.'basic_classes/ModelTemplate.php');
require_once(USER_CONTROLLERS_PATH.'Constant_Controller.php');


			require_once('models/MainMenu_Model_admin.php');
			require_once('models/MainMenu_Model_store_manager.php');
			require_once('models/MainMenu_Model_florist.php');
			require_once('models/MainMenu_Model_cashier.php');
		
class ViewBase extends ViewHTMLXSLT {	

	protected function addMenu(&$models){
		if (isset($_SESSION['role_id'])){
			$menu_class = 'MainMenu_Model_'.$_SESSION['role_id'];
			$models['mainMenu'] = new $menu_class();
		}	
	}
	
	protected function addConstants(&$models){
		if (isset($_SESSION['role_id'])){
			$dbLink = new DB_Sql();
			$dbLink->persistent=true;
			$dbLink->appname = APP_NAME;
			$dbLink->technicalemail = TECH_EMAIL;
			$dbLink->reporterror = DEBUG;
			$dbLink->database= DB_NAME;			
			$dbLink->connect(DB_SERVER,DB_USER,DB_PASSWORD,(defined('DB_PORT'))? DB_PORT:NULL);
		
			$contr = new Constant_Controller($dbLink);
			$list = array('sale_item_cols','def_store','doc_per_page_count','shift_length_time','shift_start_time','def_material_group');
			$models['ConstantList_Model'] = $contr->getConstantValueModel($list);
		}	
	}

	public function __construct($name){
		parent::__construct($name);
		
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'bootstrap.min.css'));
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'bootstrap-datepicker.standalone.min.css'));
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'metisMenu.min.css'));
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'timeline.css'));
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'sb-admin-2.css'));
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'morris.css'));		
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'font-awesome.min.css'));						
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'style.css'));
		$this->addCssModel(new ModelStyleSheet(USER_CSS_PATH.'dhtmlwindow.css'));
		
		
	
		if (!DEBUG){
			$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'lib.js'));
			$script_id = VERSION;
		}
		else{		
			
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'jquery.min.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'bootstrap.min.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'bootstrap-datepicker.min.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'bootstrap-datepicker.ru.min.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'jquery.maskedinput.min.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'metisMenu.min.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'raphael-min.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'morris.min.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'sb-admin-2.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'ext/jshash-2.2/md5-min.js'));
		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/extend.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/App.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/CommonHelper.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/DOMHelper.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/DateHelper.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/EventHelper.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ConstantManager.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ServConnector.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ServResp.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ServRespXML.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/PublicMethod.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/Controller.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ControllerDb.js'));		
				
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/Model.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelXML.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModeObjectXML.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelSingleRowXML.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelServRespXML.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/Validator.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorString.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorBool.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorDate.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorDateTime.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorTime.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorInt.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorFloat.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ValidatorEnum.js'));				
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/Field.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldString.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldEnum.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldBool.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldDate.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldDateTime.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldTime.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldInt.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldFloat.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldPassword.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/FieldText.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/ModelFilter.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/RefType.js'));		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'core/rs_rus.js'));
		
				
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/DataBinding.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Command.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/CommandBinding.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Control.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/Control.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ControlContainer.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ControlContainer.rs_rus.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewAjx.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewAjx.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ErrorControl.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Calculator.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/Calculator.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Button.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCtrl.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonEditCtrl.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonEditCtrl.rs.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCalc.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonCalc.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCalendar.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonCalendar.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonClear.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonClear.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCmd.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonExpToExcel.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonExpToExcel.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonExpToPDF.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonExpToPDF.rs_rus.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonOpen.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonOpen.rs.js'));				
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonInsert.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonInsert.rs_rus.js'));				
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonPrint.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonPrint.rs_rus.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonSelectRef.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonSelectRef.rs.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonToggle.js'));		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Label.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Edit.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/Edit.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRef.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditString.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditText.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditInt.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditFloat.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditMoney.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPhone.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditEmail.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPercent.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditDate.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditDateTime.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditTime.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPassword.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditCheckBox.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditContainer.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditContainer.rs.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRadioGroup.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRadio.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditSelect.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditSelectRef.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditSelectRef.rs.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditSelectOption.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRadioGroupRef.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditRadioGroupRef.rs.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditRef.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/HiddenKey.js'));
		
		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumn.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnBool.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnPhone.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnFloat.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridColumnDate.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCell.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCellHead.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCellFoot.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridHead.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridRow.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridFoot.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridBody.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/Grid.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/Grid.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCommands.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCommands.rs.js'));
		
		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridAjx.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridAjx.rs_rus.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridCommandsAjx.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridCommandsAjx.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridPagination.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridPagination.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/GridFilter.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/GridFilter.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPeriodDate.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/EditPeriodDate.rs.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/EditPeriodDateTime.js'));		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonOK.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonOK.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonSave.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonSave.rs_rus.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ButtonCancel.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ButtonCancel.rs.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewObjectAjx.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewObjectAjx.rs_rus.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewGridEditInlineAjx.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewGridEditInlineAjx.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/ViewDOC.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/ViewDOC.rs.js'));		

		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowPrint.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/WindowPrint.rs_rus.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowQuestion.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/WindowQuestion.rs_rus.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowForm.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowFormObject.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/WindowFormObject.rs_rus.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowFormModalBS.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/WindowMessage.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/actb.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controls/rs/actb.rs_rus.js'));
		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Constant_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Enum_Controller.js'));
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/MaterialGroup_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Material_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Product_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Specification_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Store_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Supplier_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/User_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialDisposal_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialDisposalDOCTMaterial_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialToWaste_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialToWasteDOCTMaterial_Controller.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialProcurement_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialProcurementDOCTMaterial_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialOrder_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCMaterialOrderDOCTMaterial_Controller.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProductDisposal_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProductDisposalDOCTMaterial_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProduction_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProductionDOCTMaterial_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCSale_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCSaleDOCTProduct_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCSaleDOCTMaterial_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProductOrder_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCProductOrderDOCTProduct_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/RGProductOrder_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Receipt_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/ExpenceType_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCExpence_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCExpenceDOCTExpenceType_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/RepBalance_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/RepSaleForAcc_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCClientOrder_Controller.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCClientOrderDOCTMaterial_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DOCClientOrderDOCTProduct_Controller.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/DeliveryHour_Controller.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/CashRegister_Controller.js'));				
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/PaymentTypeForSale_Controller.js'));				
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Client_Controller.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/RepSalesOnTypes_Controller.js'));		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/AppCRM.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/MaterialGroupSelect.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/StoreSelect.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/MaterialNameEdit.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/ProductNameEdit.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/SupplierNameEdit.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/ClientNameEdit.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/UserNameEdit.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/CashRegisterSelect.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/PaymentTypeForSaleSelect.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/UserEditRef.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/GridColumnCustomTime.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/MaterialGroupRadio.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/SupplierEditRef.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/ProductEditRef.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/DOCNumberEdit.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/DOCDateEdit.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/MaterialEditRef.js'));		
		
		
		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/Material_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/MaterialList_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/MaterialBalanceList_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/Supplier_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/Client_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/Product_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/User_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCProduction_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCProductDisposal_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/UserList_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/SupplierList_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/ProductList_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCSale_Form.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'forms/DOCExpence_Form.js'));				
		
		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/Login_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/rs/Login_View.rs.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/StoreList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ProductList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialGroup_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/SupplierList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ClientList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/UserList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/PaymentTypeForSale_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/CashRegister_View.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/Material_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/Product_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/Supplier_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ClientDialog_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/UserDialog_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ConstantList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/MaterialBalanceList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ProductBalanceList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCProductionList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCProductDisposalList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCMaterialDisposalList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCProductDisposal_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCMaterialProcurementList_View.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCSaleList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/ExpenceType_View.js'));		
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCExpenceList_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/UserProfile_View.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/rs/UserProfile_View.rs.js'));
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'views/DOCProduction_View.js'));
		
		
		
	$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/FileStorageSmall_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/ReportVariant_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Store_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/StoreList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ConstantList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/User_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/UserList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/UserDialog_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/CashRegister_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Client_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ClientList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ClientDialog_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Product_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ProductBalanceList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MaterialGroup_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Material_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MaterialBalanceList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Supplier_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/SupplierList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Specification_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/SpecificationList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/PaymentTypeForSale_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProduction_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductionDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposal_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCProductDisposalDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurement_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialProcurementDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrder_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialOrderDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialToWaste_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialToWasteList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialToWasteDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialToWasteDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialToWasteDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialToWasteDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposal_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCMaterialDisposalDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrder_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTFProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCClientOrderDOCTFProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSale_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDialog_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTFMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTFMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTFProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleDOCTFProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleMaterialList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCSaleProductList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Receipt_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ReceiptList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RGMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RAMaterial_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RGProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RAProduct_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RGProductOrder_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RAProductOrder_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RGMaterialCost_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RGMaterialSale_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RAMaterialSale_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RGProductSale_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RAProductSale_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ReportVariant_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ReportVariantList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RepMaterialAction_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/ExpenceType_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpence_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceExpenceTypeList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceDOCTExpenceType_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceDOCTExpenceTypeList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceDOCTFExpenceType_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DOCExpenceDOCTFExpenceTypeList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/RepBalance_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DeliveryHour_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/DeliveryHourList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/Message_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MessageRecipient_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MessageView_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/Message_Controller.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/MessageHeaderList_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_role_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_product_order_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_doc_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_reg_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_stock_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_payment_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_report_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_delivery_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_recipient_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_delivery_note_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_client_order_states.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_message_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/TemplateParam_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'custom_controls/Enum_def_date_types.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'models/UserProfile_Model.js'));$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'controllers/TemplateParam_Controller.js'));			
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
		$this->getVarModel()->addField(new Field('cash_register',DT_INT));
		$this->getVarModel()->addField(new Field('multy_store',DT_STRING));
		$this->getVarModel()->addField(new Field('debug',DT_INT));
		
		$this->getVarModel()->insert();
		$this->setVarValue('scriptId',$script_id);
		$this->setVarValue('basePath',BASE_PATH);		
		
		
		if (isset($_SESSION['constrain_to_store'])){
			$this->setVarValue('constrain_to_store',$_SESSION['constrain_to_store']);
		}
		if (isset($_SESSION['def_store_id'])){
			$this->setVarValue('def_store_id',$_SESSION['def_store_id']);
		}
		if (isset($_SESSION['role_id'])){
			$this->setVarValue('role_id',$_SESSION['role_id']);
		}
		if (isset($_SESSION['cash_register'])){
			$this->setVarValue('cash_register',$_SESSION['cash_register']);
		}
		if (isset($_SESSION['multy_store'])){
			$this->setVarValue('multy_store',$_SESSION['multy_store']);
		}
		
		//Global Filters
		
	}
	public function write(ArrayObject &$models){
		$this->addMenu($models);
		
		
		
		$this->addConstants($models);
		
		
		//template
		if (isset($_REQUEST['t'])){
			$tmpl = $_REQUEST['t']; 
			if (file_exists($file = USER_VIEWS_PATH. $tmpl. '.html') ){
				$text = $this->convToUtf8(file_get_contents($file));
				$models[$tmpl] = new ModelTemplate($tmpl,$text);
			}
		}		
		parent::write($models);
	}	
}	
?>
