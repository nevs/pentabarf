<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in ui_message.
*/

class UI_Message extends Entity {

  public function __construct($select = array())
  {
    $this->table = "ui_message";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['ui_message_id']['type'] = 'SERIAL';
    $this->field['ui_message_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 128;
    $this->field['tag']['not_null'] = true;
    $this->field['ui_message_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
