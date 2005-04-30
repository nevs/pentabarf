<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table keyword
class KEYWORD extends DB_BASE
{
   /// constructor of the class keyword
   public function __construct()
   {
      parent::__construct();
      $this->table = 'keyword';
      $this->domain = 'keyword';
      $this->limit = 0;
      $this->order = '';

      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['keyword_id'] = new DT_SERIAL( $this, 'keyword_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
