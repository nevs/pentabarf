<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_timestamp.php');
require_once('../classes/database/datatypes/dt_smallint.php');

/// class for accessing and manipulating content of table person_rating
class PERSON_RATING extends DB_BASE
{
   /// constructor of the class person_rating
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_rating';
      $this->domain = 'person_rating';
      $this->limit = 0;
      $this->order = '';

      $this->fields['competence_comment'] = new DT_VARCHAR( $this, 'competence_comment', array('length' => 128), array() );
      $this->fields['speaker_quality'] = new DT_SMALLINT( $this, 'speaker_quality', array(), array() );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
      $this->fields['evaluator_id'] = new DT_INTEGER( $this, 'evaluator_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['eval_time'] = new DT_TIMESTAMP( $this, 'eval_time', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['competence'] = new DT_SMALLINT( $this, 'competence', array(), array() );
      $this->fields['quality_comment'] = new DT_VARCHAR( $this, 'quality_comment', array('length' => 128), array() );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
