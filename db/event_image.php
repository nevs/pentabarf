<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_image.
*/

class Event_Image extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_image";
    $this->order = "";
    $this->domain = "event";
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['not_null'] = true;
    $this->field['mime_type_id']['type'] = 'INTEGER';
    $this->field['mime_type_id']['not_null'] = true;
    $this->field['image']['type'] = 'BYTEA';
    $this->field['image']['not_null'] = true;
    $this->field['event_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
