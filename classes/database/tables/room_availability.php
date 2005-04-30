<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_interval.php');

/// class for accessing and manipulating content of table room_availability
class ROOM_AVAILABILITY extends DB_BASE
{
   /// constructor of the class room_availability
   public function __construct()
   {
      parent::__construct();
      $this->table = 'room_availability';
      $this->domain = 'room_availability';
      $this->limit = 0;
      $this->order = '';

      $this->fields['duration'] = new DT_INTERVAL( $this, 'duration', array(), array('NOT_NULL' => true) );
      $this->fields['room_id'] = new DT_INTEGER( $this, 'room_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['start_time'] = new DT_INTERVAL( $this, 'start_time', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
