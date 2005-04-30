<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');

/// class for accessing and manipulating content of table person_keyword
class PERSON_KEYWORD extends DB_BASE
{
   /// constructor of the class person_keyword
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_keyword';
      $this->domain = 'person_keyword';
      $this->limit = 0;
      $this->order = '';

      $this->fields['keyword_id'] = new DT_INTEGER( $this, 'keyword_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
