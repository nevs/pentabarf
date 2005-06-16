<?php

require_once("view.php");

/**
 * Class to easily access all information relevant to events.
*/
class View_Fahrplan_Event_no_Timetable extends View {

  /**
   * Constructor of the class.
  */
  public function __construct($select = array())
  {
    $this->table = "event LEFT OUTER JOIN room USING (room_id), event_state, conference";
    $this->domain = "event";
    $this->order = "lower(event.title), lower(event.subtitle)";
    $this->join = "event.event_state_id = event_state.event_state_id AND event_state.tag = 'confirmed' AND event.conference_id = conference.conference_id";
    $this->field['event_id']['type'] = 'SERIAL';
    $this->field['event_id']['table'] = 'event';
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['table'] = 'event';
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['table'] = 'event';
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['table'] = 'event';
    $this->field['subtitle']['type'] = 'VARCHAR';
    $this->field['subtitle']['table'] = 'event';
    $this->field['conference_track_id']['type'] = 'INTEGER';
    $this->field['conference_track_id']['table'] = 'event';
    $this->field['team_id']['type'] = 'INTEGER';
    $this->field['team_id']['table'] = 'event';
    $this->field['event_type_id']['type'] = 'INTEGER';
    $this->field['event_type_id']['table'] = 'event';
    $this->field['duration']['type'] = 'INTERVAL';
    $this->field['duration']['table'] = 'event';
    $this->field['event_state_id']['type'] = 'INTEGER';
    $this->field['event_state_id']['table'] = 'event';
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['table'] = 'event';
    $this->field['room_id']['type'] = 'INTEGER';
    $this->field['room_id']['table'] = 'event';
    $this->field['day']['type'] = 'SMALLINT';
    $this->field['day']['table'] = 'event';
    $this->field['abstract']['type'] = 'TEXT';
    $this->field['abstract']['table'] = 'event';
    $this->field['description']['type'] = 'TEXT';
    $this->field['description']['table'] = 'event';
    $this->field['resources']['type'] = 'TEXT';
    $this->field['resources']['table'] = 'event';
    $this->field['f_public']['type'] = 'BOOL';
    $this->field['f_public']['table'] = 'event';
    $this->field['f_conflict']['type'] = 'BOOL';
    $this->field['f_conflict']['table'] = 'event';
    $this->field['f_deleted']['type'] = 'BOOL';
    $this->field['f_deleted']['table'] = 'event';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['remark']['table'] = 'event';
    $this->field['relative_start_time']['type'] = 'INTERVAL';
    $this->field['relative_start_time']['name'] = 'event.start_time';

    $this->field['room']['type'] = 'VARCHAR';
    $this->field['room']['name'] = 'room.short_name';

    $this->field['start_time']['type'] = 'TIME';
    $this->field['start_time']['name'] = 'conference.day_change + event.start_time';
    $this->field['start_datetime']['type'] = 'DATETIME';
    $this->field['start_datetime']['name'] = '(conference.start_date + event.day + \'-1\'::integer + event.start_time + conference.day_change)::timestamp';
    
    parent::__construct($select);

  }

}

?>
