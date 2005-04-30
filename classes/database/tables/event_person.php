<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table event_person
class EVENT_PERSON extends DB_BASE
{
   /// constructor of the class event_person
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_person';
      $this->domain = 'event_person';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id'] = new DT_INTEGER( $this, 'event_id', array(), array('NOT_NULL' => true) );
      $this->fields['event_role_id'] = new DT_INTEGER( $this, 'event_role_id', array(), array('NOT_NULL' => true) );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
      $this->fields['event_person_id'] = new DT_SERIAL( $this, 'event_person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['event_role_state_id'] = new DT_INTEGER( $this, 'event_role_state_id', array(), array() );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true) );
   }

}

?>
