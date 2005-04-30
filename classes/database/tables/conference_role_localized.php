<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table conference_role_localized
class CONFERENCE_ROLE_LOCALIZED extends DB_BASE
{
   /// constructor of the class conference_role_localized
   public function __construct()
   {
      parent::__construct();
      $this->table = 'conference_role_localized';
      $this->domain = 'conference_role_localized';
      $this->limit = 0;
      $this->order = '';

      $this->fields['name'] = new DT_VARCHAR( $this, 'name', array('length' => 64), array() );
      $this->fields['conference_role_id'] = new DT_INTEGER( $this, 'conference_role_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['language_id'] = new DT_INTEGER( $this, 'language_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
