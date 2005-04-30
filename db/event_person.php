<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_person.
*/

class Event_Person extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_person";
    $this->order = "";
    $this->domain = "event";
    $this->field['event_person_id']['type'] = 'SERIAL';
    $this->field['event_person_id']['not_null'] = true;
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['not_null'] = true;
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['event_role_id']['type'] = 'INTEGER';
    $this->field['event_role_id']['not_null'] = true;
    $this->field['event_role_state_id']['type'] = 'INTEGER';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['event_person_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
