<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_bytea.php');

/// class for accessing and manipulating content of table room_image
class ROOM_IMAGE extends DB_BASE
{
   /// constructor of the class room_image
   public function __construct()
   {
      parent::__construct();
      $this->table = 'room_image';
      $this->domain = 'room_image';
      $this->limit = 0;
      $this->order = '';

      $this->fields['mime_type_id'] = new DT_INTEGER( $this, 'mime_type_id', array(), array('NOT_NULL' => true) );
      $this->fields['image'] = new DT_BYTEA( $this, 'image', array(), array('NOT_NULL' => true) );
      $this->fields['room_id'] = new DT_INTEGER( $this, 'room_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
