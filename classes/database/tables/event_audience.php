<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table event_audience
class EVENT_AUDIENCE extends DB_BASE
{
   /// constructor of the class event_audience
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_audience';
      $this->domain = 'event_audience';
      $this->limit = 0;
      $this->order = '';

      $this->fields['audience_id'] = new DT_INTEGER( $this, 'audience_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['event_id'] = new DT_INTEGER( $this, 'event_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
