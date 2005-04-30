<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table event_keyword
class EVENT_KEYWORD extends DB_BASE
{
   /// constructor of the class event_keyword
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_keyword';
      $this->domain = 'event_keyword';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id'] = new DT_INTEGER( $this, 'event_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['keyword_id'] = new DT_INTEGER( $this, 'keyword_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
