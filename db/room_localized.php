<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in room_localized.
*/

class Room_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "room_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['room_id']['type'] = 'INTEGER';
    $this->field['room_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['public_name']['type'] = 'VARCHAR';
    $this->field['public_name']['length'] = 64;
    $this->field['public_name']['not_null'] = true;
    $this->field['description']['type'] = 'TEXT';
    $this->field['room_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
