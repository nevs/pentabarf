<?php

require_once("view.php");

/**
 * Class to easily access all information relevant to events.
*/
class View_Fahrplan_Person_Event extends View {

  /**
   * Constructor of the class.
  */
  public function __construct($select = array())
  {
    $this->table= "event, event_person, event_state, event_role_state, event_role";
    $this->domain = "event";
    $this->order = "lower(event.title), lower(event.subtitle)";
    $this->join = "event_person.event_id = event.event_id AND event.event_state_id = event_state.event_state_id AND event_person.event_role_state_id = event_role_state.event_role_state_id AND event_state.tag = 'confirmed' AND event_role_state.tag = 'confirmed' AND event_person.event_role_id = event_role.event_role_id AND event.f_public = TRUE";
    $this->field['event_id']['type'] = 'SERIAL';
    $this->field['event_id']['table'] = 'event';
    $this->field['person_id']['type'] = 'SERIAL';
    $this->field['person_id']['table'] = 'event_person';
    $this->field['event_role_tag']['type'] = 'VARCHAR';
    $this->field['event_role_tag']['name'] = 'event_role.tag';
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['table'] = 'event';
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['table'] = 'event';
    $this->field['subtitle']['type'] = 'VARCHAR';
    $this->field['subtitle']['table'] = 'event';
    $this->field['event_type_id']['type'] = 'INTEGER';
    $this->field['event_type_id']['table'] = 'event';
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['table'] = 'event';
    $this->field['room_id']['type'] = 'INTEGER';
    $this->field['room_id']['table'] = 'event';
    $this->field['day']['type'] = 'SMALLINT';
    $this->field['day']['table'] = 'event';

    parent::__construct($select);

  }

}

?>
