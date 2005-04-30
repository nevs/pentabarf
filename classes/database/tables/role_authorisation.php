<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table role_authorisation
class ROLE_AUTHORISATION extends DB_BASE
{
   /// constructor of the class role_authorisation
   public function __construct()
   {
      parent::__construct();
      $this->table = 'role_authorisation';
      $this->domain = 'role_authorisation';
      $this->limit = 0;
      $this->order = '';

      $this->fields['authorisation_id'] = new DT_INTEGER( $this, 'authorisation_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['role_id'] = new DT_INTEGER( $this, 'role_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
