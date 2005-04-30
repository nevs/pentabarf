<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table person_role
class PERSON_ROLE extends DB_BASE
{
   /// constructor of the class person_role
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_role';
      $this->domain = 'person_role';
      $this->limit = 0;
      $this->order = '';

      $this->fields['role_id'] = new DT_INTEGER( $this, 'role_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
