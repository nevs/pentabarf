<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table room
class ROOM extends DB_BASE
{
   /// constructor of the class room
   public function __construct()
   {
      parent::__construct();
      $this->table = 'room';
      $this->domain = 'room';
      $this->limit = 0;
      $this->order = '';

      $this->fields['size'] = new DT_INTEGER( $this, 'size', array(), array() );
      $this->fields['f_public'] = new DT_BOOL( $this, 'f_public', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['short_name'] = new DT_VARCHAR( $this, 'short_name', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array('NOT_NULL' => true) );
      $this->fields['room_id'] = new DT_SERIAL( $this, 'room_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
