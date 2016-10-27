<?php
require_once('common/SMSService.php');
function send_service_sms($phone_cel,$text){
	$phone_cel=str_replace('-','',$phone_cel);
	if (SMS_ACTIVE && strlen($phone_cel)){
		$sms_service = new SMSService(SMS_LOGIN, SMS_PWD);
		$sms_id_resp = $sms_service->send($phone_cel,$text,SMS_SIGN,SMS_TEST);	
	}
}
?>