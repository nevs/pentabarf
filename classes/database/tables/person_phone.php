<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table person_phone
class PERSON_PHONE extends DB_BASE
{
   /// constructor of the class person_phone
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_phone';
      $this->domain = 'person_phone';
      $this->limit = 0;
      $this->order = '';

      $this->fields['person_phone_id'] = new DT_SERIAL( $this, 'person_phone_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['phone_number'] = new DT_VARCHAR( $this, 'phone_number', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['phone_type_id'] = new DT_INTEGER( $this, 'phone_type_id', array(), array('NOT_NULL' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true) );
   }

}

?>
