<?php

require_once("view_event_person.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_person.
*/

class View_Envelope extends View
{

  public function __construct($select = array())
  {
    $this->table = "event_person, person, event_role, event_role_localized";
    $this->order = "lower(coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name))";
    $this->domain = "event";
    $this->join = "event_person.person_id = person.person_id AND event_person.event_role_id = event_role.event_role_id AND event_person.event_role_id = event_role_localized.event_role_id AND event_role_localized.language_id = {$this->get_language_id()}";
    $this->field['first_name']['type'] = 'VARCHAR';
    $this->field['last_name']['type'] = 'VARCHAR';
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['title']['type'] = 'TEXT';
    $this->field['day']['type'] = 'INTEGER';
    $this->field['room']['type'] = 'TEXT';
    $this->field['start_time']['type'] = 'INTERVAL';
    parent::__construct($select);
  }

    public function select($conference)
    {
      $this->clear();
      $conference = intval($conference) > 0 ? intval($conference) : 2;
      $sql = "SELECT last_name, first_name, name, event.title, event.day, room.short_name AS room, event.start_time + conference.day_change AS start_time from event_person INNER JOIN view_person USING (person_id) INNER JOIN event USING (event_id) INNER JOIN event_state USING (event_state_id) INNER JOIN event_role USING (event_role_id) INNER JOIN event_role_state USING (event_role_state_id) INNER JOIN conference USING (conference_id) INNER JOIN room USING (room_id) WHERE event_state.tag = 'confirmed' AND event_role.tag IN ('speaker', 'moderator') AND event_role_state.tag = 'confirmed' AND conference.conference_id = {$conference} ORDER BY name, event.title;";
      return $this->real_select($sql);
    }
  
}

?>
