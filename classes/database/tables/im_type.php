<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table im_type
class IM_TYPE extends DB_BASE
{
   /// constructor of the class im_type
   public function __construct()
   {
      parent::__construct();
      $this->table = 'im_type';
      $this->domain = 'im_type';
      $this->limit = 0;
      $this->order = '';

      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['scheme'] = new DT_VARCHAR( $this, 'scheme', array('length' => 32), array() );
      $this->fields['im_type_id'] = new DT_SERIAL( $this, 'im_type_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
