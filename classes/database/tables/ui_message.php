<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table ui_message
class UI_MESSAGE extends DB_BASE
{
   /// constructor of the class ui_message
   public function __construct()
   {
      parent::__construct();
      $this->table = 'ui_message';
      $this->domain = 'ui_message';
      $this->limit = 0;
      $this->order = '';

      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 128), array('NOT_NULL' => true) );
      $this->fields['ui_message_id'] = new DT_SERIAL( $this, 'ui_message_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
