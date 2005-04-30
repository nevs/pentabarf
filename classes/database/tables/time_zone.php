<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table time_zone
class TIME_ZONE extends DB_BASE
{
   /// constructor of the class time_zone
   public function __construct()
   {
      parent::__construct();
      $this->table = 'time_zone';
      $this->domain = 'time_zone';
      $this->limit = 0;
      $this->order = '';

      $this->fields['f_preferred'] = new DT_BOOL( $this, 'f_preferred', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['f_visible'] = new DT_BOOL( $this, 'f_visible', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['time_zone_id'] = new DT_SERIAL( $this, 'time_zone_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
