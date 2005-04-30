<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table person_im
class PERSON_IM extends DB_BASE
{
   /// constructor of the class person_im
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_im';
      $this->domain = 'person_im';
      $this->limit = 0;
      $this->order = '';

      $this->fields['im_address'] = new DT_VARCHAR( $this, 'im_address', array('length' => 128), array('NOT_NULL' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['person_im_id'] = new DT_SERIAL( $this, 'person_im_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['im_type_id'] = new DT_INTEGER( $this, 'im_type_id', array(), array('NOT_NULL' => true) );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true) );
   }

}

?>
