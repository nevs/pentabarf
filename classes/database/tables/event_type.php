<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table event_type
class EVENT_TYPE extends DB_BASE
{
   /// constructor of the class event_type
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_type';
      $this->domain = 'event_type';
      $this->limit = 0;
      $this->order = '';

      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['event_type_id'] = new DT_SERIAL( $this, 'event_type_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
