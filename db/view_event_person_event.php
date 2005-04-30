<?php

require_once("view_event_person.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_person.
*/

class View_Event_Person_Event extends View_Event_Person
{

  public function __construct($select = array())
  {
    $this->table = "event_person, event, event_state_localized, event_state, event_role, event_role_localized";
    $this->order = "lower(event.title), lower(event.subtitle)";
    $this->domain = "event";
    $this->join = "event_person.event_id = event.event_id AND event.event_state_id = event_state_localized.event_state_id AND event.event_state_id = event_state.event_state_id AND event_state_localized.language_id = {$this->get_language_id()} AND event_person.event_role_id = event_role.event_role_id AND event_person.event_role_id = event_role_localized.event_role_id AND event_role_localized.language_id = {$this->get_language_id()}";
    $this->field['conference_id']['type'] = 'SERIAL';
    $this->field['conference_id']['table'] = 'event';
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['table'] = 'event';
    $this->field['subtitle']['type'] = 'VARCHAR';
    $this->field['subtitle']['table'] = 'event';
    $this->field['event_state_id']['type'] = 'INTEGER';
    $this->field['event_state_id']['table'] = 'event';
    $this->field['event_state']['type'] = 'VARCHAR';
    $this->field['event_state']['name'] = 'event_state_localized.name';
    $this->field['event_state_tag']['type'] = 'VARCHAR';
    $this->field['event_state_tag']['name'] = 'event_state.tag';
    $this->field['event_role']['type'] = 'VARCHAR';
    $this->field['event_role']['name'] = 'event_role_localized.name';
    $this->field['event_role_tag']['type'] = 'VARCHAR';
    $this->field['event_role_tag']['name'] = 'event_role.tag';
    $this->field['conference_id']['type'] = 'SERIAL';
    $this->field['conference_id']['table'] = 'event';
    parent::__construct($select);
  }

}

?>
