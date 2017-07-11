<?php
require_once(FRAME_WORK_PATH.'basic_classes/ControllerSQL.php');

require_once(FRAME_WORK_PATH.'basic_classes/FieldExtInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtDate.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtPassword.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtInterval.php');

require_once(FRAME_WORK_PATH.'basic_classes/ParamsSQL.php');

require_once('models/DOCReprocessStatList_Model.php');

class DOCManager_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);
			
		$pm = new PublicMethod('reprocess');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('sequence_list',$opts));
	
			
		$this->addPublicMethod($pm);

			
		/* get_list */
		$pm = new PublicMethod('get_list');
		$pm->addParam(new FieldExtInt('browse_mode'));
		$pm->addParam(new FieldExtInt('browse_id'));		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));
		$pm->addParam(new FieldExtString('cond_fields'));
		$pm->addParam(new FieldExtString('cond_sgns'));
		$pm->addParam(new FieldExtString('cond_vals'));
		$pm->addParam(new FieldExtString('cond_ic'));
		$pm->addParam(new FieldExtString('ord_fields'));
		$pm->addParam(new FieldExtString('ord_directs'));
		$pm->addParam(new FieldExtString('field_sep'));
		
		$this->addPublicMethod($pm);
		
		$this->setListModelId('DOCManagerList_Model');
		
			
		$pm = new PublicMethod('get_sequence_viol_list');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('sequence_list',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_reprocess_list');
		
		$this->addPublicMethod($pm);

		
	}	
	
	public function reprocess($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();

		$list = explode(',',$p->getVal('sequence_list'));

		if (isset($_SESSION) && $_SESSION['user_id']){
			$user_id = $_SESSION['user_id'];
		}
		else{
			$user_id = 'NULL';
		}

		$sequence_list_db = "";
		
		$doc_type_dates = array();
		$doc_type_list_db = '';
		
		foreach($list as $seq){
			$sequence_list_db.= ($sequence_list_db=="")? "":",";
			$sequence_list_db.= "'".$seq."'";
			
		}
	
		if (!strlen($sequence_list_db)){
			throw new Exception('No sequence defined!');
		}
		
		$l = $this->getDbLinkMaster();
				
		$l->query(sprintf("DELETE FROM doc_reprocess_stat WHERE doc_sequence IN (%s)",$sequence_list_db));
	
		$q_id = $l->query(sprintf(
		"SELECT cont.doc_type,
			min(s.doc_log_date_time) AS start_date
		FROM seq_contents cont
		LEFT JOIN seq_violations s ON s.doc_sequence=cont.doc_sequence
		WHERE cont.doc_sequence IN ('materials','seq2')
		GROUP BY cont.doc_type",
		$sequence_list_db
		));
	
		while($ar = $l->fetch_array($q_id)){
			$doc_type_dates[$ar['doc_type']] = strtotime($ar['start_date']);
			
			$doc_type_list_db.= ($doc_type_list_db=="")? "":",";
			$doc_type_list_db.= "'".$ar['doc_type']."'";			
		}
	
		//************ MAIN QUERY DOC SELECTION *********************
		$id = $l->query(sprintf(
		"SELECT
			doc_type,
			date_time,
			doc_id,
			doc_table(doc_type) AS doc_table
		FROM doc_log
		WHERE date_time>=(SELECT min(s.doc_log_date_time) FROM seq_violations s WHERE s.doc_sequence IN (%s) AND reprocessing=FALSE)
			AND doc_type IN (%s)
		ORDER BY date_time",
		$sequence_list_db,$doc_type_list_db
		));
		
		$count_total = $l->num_rows();
		$count_done = 0;
		
		$reprocess_res = 'TRUE';
		$reprocess_res_str = 'NULL';
		
		
		
		try{
			while ($ar = $l->fetch_array($id)){
				if ($count_done==0){
					$i_q = '';
					foreach($list as $seq){
						$i_q.= ($i_q=="")? "":",";
						$i_q.= sprintf(
						"('%s',now(),now(),%d,0,%s)",
						$seq,$count_total,$user_id
						);			
					}
					
					$l->query(sprintf(
					"INSERT INTO doc_reprocess_stat
					(doc_sequence,start_time,update_time,count_total,count_done,user_id)
					VALUES %s",
					$i_q
					));
					
					$l->query(sprintf(			
					"UPDATE seq_violations SET reprocessing=TRUE WHERE doc_sequence IN (%s)",
					$sequence_list_db
					));
				}
				else{
					$l->query(sprintf(
					"UPDATE doc_reprocess_stat
					SET
						time_to_go = ( ((count_total-count_done)*EXTRACT(epoch FROM now()-start_time)/%d ) || ' seconds')::interval,
						update_time = now(),
						count_done=%d,
						doc_id=%d,
						doc_type='%s'
					WHERE doc_sequence IN (%s)",
						$count_done,$count_done,$ar['doc_id'],$ar['doc_type'],$sequence_list_db
					));			
			
				}

				//DO WE NEED TO PROCESS THIS DOC
				//OR IT WAS SELECTED WITH OTHER SEQUENCES
				if ($doc_type_dates[$ar['doc_type']] <= $ar['date_time']){
					$l->query(sprintf("SELECT %s_act(%d)",$ar['doc_table'],$ar['doc_id']));
				}
			
				$count_done++;
			}
			
			$l->query(sprintf("DELETE FROM seq_violations WHERE doc_sequence IN (%s)",$sequence_list_db));			
		}
		catch (Exception $e){
			$reprocess_res = 'FALSE';
			$reprocess_res_str = "'".$e->getMessage()."'";
		}
				
		$l->query(sprintf(
		"UPDATE doc_reprocess_stat
		SET
			end_time = now(),
			count_done=%d,
			res = %s,
			error_message=%s
		WHERE doc_sequence IN (%s)",
		$count_done,$reprocess_res,$reprocess_res_str,$sequence_list_db
		));			
		
		if ($reprocess_res == 'FALSE'){
			throw new Exception($e);
		}
		
	}
	
	public function get_sequence_viol_list($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();

		$list = explode(',',$p->getVal('sequence_list'));

		$sequence_list_db = "";
		foreach($list as $seq){
			$sequence_list_db.= ($sequence_list_db=="")? "":",";
			$sequence_list_db.= "'".$seq."'";			
		}
		
		if (strlen($sequence_list_db)){
			$sequence_list_db = sprintf(' WHERE doc_sequence IN (%s)',$sequence_list_db);
		}
	
		$this->addNewModel(
			"SELECT doc_sequence,doc_log_date_time FROM seq_violations".$sequence_list_db,"SequenceViolList_Model");
	}
	
	public function get_reprocess_list($pm){
		$model = new DOCReprocessStatList_Model($this->getDbLink());
		$model->select(FALSE,
					NULL,NULL,NULL,NULL,
					NULL,NULL,
					TRUE,TRUE);
		$this->addModel($model);				
	}
	

}
?>