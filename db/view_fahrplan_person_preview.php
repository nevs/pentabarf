<?php

require_once("view.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_person.
*/

class View_Fahrplan_Person_Preview extends View
{
  public function __construct($select = array())
  {
    $this->distinct = "person_id";
    $this->table = "event_person, person, event_role, event_role_localized, event, event_state, event_role_state";
    $this->domain = "person";
    $this->order = "lower(coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name))";
    $this->join = "event.event_state_id = event_state.event_state_id AND event_state.tag IN ('confirmed', 'accepted') AND event_person.event_id = event.event_id AND event_person.person_id = person.person_id AND event_person.event_role_id = event_role.event_role_id AND event_person.event_role_id = event_role_localized.event_role_id AND event_role_localized.language_id = {$this->get_language_id()} AND event_person.event_role_state_id = event_role_state.event_role_state_id AND event_role_state.tag = 'confirmed' AND event.f_public = TRUE";
    $this->field['event_id']['type'] = 'SERIAL';
    $this->field['event_id']['table'] = 'event';
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['table'] = 'event';
 
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['name'] = 'coalesce(person.public_name, coalesce(person.first_name || \' \', \'\') || person.last_name, person.nickname, person.login_name)';
    $this->field['person_id']['type'] = 'SERIAL';
    $this->field['person_id']['table'] = 'person';
    $this->field['first_name']['type'] = 'VARCHAR';
    $this->field['first_name']['table'] = 'person';
    $this->field['last_name']['type'] = 'VARCHAR';
    $this->field['last_name']['table'] = 'person';
    $this->field['description']['type'] = 'TEXT';
    $this->field['description']['table'] = 'person';
    $this->field['event_role']['type'] = 'VARCHAR';
    $this->field['event_role']['name'] = 'event_role_localized.name';
    $this->field['event_role_tag']['type'] = 'VARCHAR';
    $this->field['event_role_tag']['name'] = 'event_role.tag';
    $this->field['email_public']['type'] = 'VARCHAR';
    $this->field['email_public']['table'] = 'person';
    $this->field['email_contact']['type'] = 'VARCHAR';
    $this->field['email_contact']['table'] = 'person';
    parent::__construct($select);

  }

}

?>
