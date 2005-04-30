<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_type.
*/

class Event_Type extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_type";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['event_type_id']['type'] = 'SERIAL';
    $this->field['event_type_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['event_type_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
