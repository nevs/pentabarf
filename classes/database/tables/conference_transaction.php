<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_timestamp.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table conference_transaction
class CONFERENCE_TRANSACTION extends DB_BASE
{
   /// constructor of the class conference_transaction
   public function __construct()
   {
      parent::__construct();
      $this->table = 'conference_transaction';
      $this->domain = 'conference_transaction';
      $this->limit = 0;
      $this->order = '';

      $this->fields['changed_by'] = new DT_INTEGER( $this, 'changed_by', array(), array('NOT_NULL' => true) );
      $this->fields['f_create'] = new DT_BOOL( $this, 'f_create', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['changed_when'] = new DT_TIMESTAMP( $this, 'changed_when', array(), array('DEFAULT' => true, 'NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
