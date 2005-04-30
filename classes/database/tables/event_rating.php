<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_timestamp.php');
require_once('../classes/database/datatypes/dt_smallint.php');

/// class for accessing and manipulating content of table event_rating
class EVENT_RATING extends DB_BASE
{
   /// constructor of the class event_rating
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_rating';
      $this->domain = 'event_rating';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id'] = new DT_INTEGER( $this, 'event_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['relevance_comment'] = new DT_VARCHAR( $this, 'relevance_comment', array('length' => 128), array() );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
      $this->fields['eval_time'] = new DT_TIMESTAMP( $this, 'eval_time', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['relevance'] = new DT_SMALLINT( $this, 'relevance', array(), array() );
      $this->fields['documentation_comment'] = new DT_VARCHAR( $this, 'documentation_comment', array('length' => 128), array() );
      $this->fields['documentation'] = new DT_SMALLINT( $this, 'documentation', array(), array() );
      $this->fields['quality_comment'] = new DT_VARCHAR( $this, 'quality_comment', array('length' => 128), array() );
      $this->fields['quality'] = new DT_SMALLINT( $this, 'quality', array(), array() );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
