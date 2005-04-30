<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table person_watchlist_person
class PERSON_WATCHLIST_PERSON extends DB_BASE
{
   /// constructor of the class person_watchlist_person
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_watchlist_person';
      $this->domain = 'person_watchlist_person';
      $this->limit = 0;
      $this->order = '';

      $this->fields['watched_person_id'] = new DT_INTEGER( $this, 'watched_person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
