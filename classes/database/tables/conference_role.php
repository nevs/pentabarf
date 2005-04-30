<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table conference_role
class CONFERENCE_ROLE extends DB_BASE
{
   /// constructor of the class conference_role
   public function __construct()
   {
      parent::__construct();
      $this->table = 'conference_role';
      $this->domain = 'conference_role';
      $this->limit = 0;
      $this->order = '';

      $this->fields['conference_role_id'] = new DT_SERIAL( $this, 'conference_role_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array() );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
   }

}

?>
