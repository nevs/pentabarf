<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table event_related
class EVENT_RELATED extends DB_BASE
{
   /// constructor of the class event_related
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_related';
      $this->domain = 'event_related';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id1'] = new DT_INTEGER( $this, 'event_id1', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['event_id2'] = new DT_INTEGER( $this, 'event_id2', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
