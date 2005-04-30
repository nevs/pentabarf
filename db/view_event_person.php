<?php

require_once("view.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_person.
*/

abstract class View_Event_Person extends View
{

  public function __construct($select = array())
  {
    $this->domain = "event";
    $this->field['event_person_id']['type'] = 'INTEGER';
    $this->field['event_person_id']['table'] = 'event_person';
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['table'] = 'event_person';
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['table'] = 'event_person';
    $this->field['event_role_id']['type'] = 'INTEGER';
    $this->field['event_role_id']['table'] = 'event_person';
    $this->field['event_role_state_id']['type'] = 'INTEGER';
    $this->field['event_role_state_id']['table'] = 'event_person';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['remark']['table'] = 'event_person';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['rank']['table'] = 'event_person';
    parent::__construct($select);
  }

}

?>
