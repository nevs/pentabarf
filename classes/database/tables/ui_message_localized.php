<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');

/// class for accessing and manipulating content of table ui_message_localized
class UI_MESSAGE_LOCALIZED extends DB_BASE
{
   /// constructor of the class ui_message_localized
   public function __construct()
   {
      parent::__construct();
      $this->table = 'ui_message_localized';
      $this->domain = 'ui_message_localized';
      $this->limit = 0;
      $this->order = '';

      $this->fields['name'] = new DT_TEXT( $this, 'name', array(), array('NOT_NULL' => true) );
      $this->fields['language_id'] = new DT_INTEGER( $this, 'language_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['ui_message_id'] = new DT_INTEGER( $this, 'ui_message_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
