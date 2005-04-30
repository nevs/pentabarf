<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');

/// class for accessing and manipulating content of table room_localized
class ROOM_LOCALIZED extends DB_BASE
{
   /// constructor of the class room_localized
   public function __construct()
   {
      parent::__construct();
      $this->table = 'room_localized';
      $this->domain = 'room_localized';
      $this->limit = 0;
      $this->order = '';

      $this->fields['public_name'] = new DT_VARCHAR( $this, 'public_name', array('length' => 64), array('NOT_NULL' => true) );
      $this->fields['description'] = new DT_TEXT( $this, 'description', array(), array() );
      $this->fields['language_id'] = new DT_INTEGER( $this, 'language_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['room_id'] = new DT_INTEGER( $this, 'room_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
