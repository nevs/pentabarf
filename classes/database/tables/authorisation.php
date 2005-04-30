<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table authorisation
class AUTHORISATION extends DB_BASE
{
   /// constructor of the class authorisation
   public function __construct()
   {
      parent::__construct();
      $this->table = 'authorisation';
      $this->domain = 'authorisation';
      $this->limit = 0;
      $this->order = '';

      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['authorisation_id'] = new DT_SERIAL( $this, 'authorisation_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
   }

}

?>
