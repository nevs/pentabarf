<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table person_watchlist_event
class PERSON_WATCHLIST_EVENT extends DB_BASE
{
   /// constructor of the class person_watchlist_event
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_watchlist_event';
      $this->domain = 'person_watchlist_event';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id'] = new DT_INTEGER( $this, 'event_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
