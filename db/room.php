<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in room.
*/

class Room extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "room";
    $this->order = "";
    $this->domain = "conference";
    $this->field['room_id']['type'] = 'SERIAL';
    $this->field['room_id']['not_null'] = true;
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['not_null'] = true;
    $this->field['short_name']['type'] = 'VARCHAR';
    $this->field['short_name']['length'] = 32;
    $this->field['short_name']['not_null'] = true;
    $this->field['f_public']['type'] = 'BOOL';
    $this->field['f_public']['not_null'] = true;
    $this->field['f_public']['default'] = true;
    $this->field['size']['type'] = 'INTEGER';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['room_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
