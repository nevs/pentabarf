<?php

require_once("view_event_person.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_person.
*/

class View_Event_Person_Person extends View_Event_Person
{

  public function __construct($select = array())
  {
    $this->table = "event_person, person, event_role, event_role_localized";
    $this->order = "lower(coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name))";
    $this->domain = "event";
    $this->join = "event_person.person_id = person.person_id AND event_person.event_role_id = event_role.event_role_id AND event_person.event_role_id = event_role_localized.event_role_id AND event_role_localized.language_id = {$this->get_language_id()}";
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['name'] = 'coalesce(person.public_name, coalesce(person.first_name || \' \', \'\') || person.last_name, person.nickname, person.login_name)';
    $this->field['event_role']['type'] = 'VARCHAR';
    $this->field['event_role']['name'] = 'event_role_localized.name';
    $this->field['event_role_tag']['type'] = 'VARCHAR';
    $this->field['event_role_tag']['name'] = 'event_role.tag';
    $this->field['email_public']['type'] = 'VARCHAR';
    $this->field['email_public']['table'] = 'person';
    $this->field['email_contact']['type'] = 'VARCHAR';
    $this->field['email_contact']['table'] = 'person';
    $this->field['abstract']['type'] = 'TEXT';
    $this->field['abstract']['table'] = 'person';
    $this->field['description']['type'] = 'TEXT';
    $this->field['description']['table'] = 'person';
    parent::__construct($select);
  }

}

?>
