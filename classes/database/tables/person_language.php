<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table person_language
class PERSON_LANGUAGE extends DB_BASE
{
   /// constructor of the class person_language
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_language';
      $this->domain = 'person_language';
      $this->limit = 0;
      $this->order = '';

      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['language_id'] = new DT_INTEGER( $this, 'language_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
