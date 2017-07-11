<?php
require_once('db_con.php');
require_once(USER_CONTROLLERS_PATH.'DOCManager_Controller.php');

$seq_list = '';
$id = $dbLink->query("SELECT DISTINCT doc_sequence FROM seq_contents");
while($ar = $dbLink->fetch_array($id)){
	$seq_list.= ($seq_list=='')? '':',';
	$seq_list.= $ar['doc_sequence'];
}

if (!strlen($seq_list)) return;

$doc_man = new DOCManager_Controller($dbLink);
$pm = $doc_man->getPublicMethod('reprocess');
$pm->setParamValue('sequence_list',$seq_list);
$doc_man->reprocess($pm);

?>
