<?php

  require_once("../db/find.php");

  class Find_Event extends Find
  {
    public function __construct($condition = array())
    {
      $this->table = "event, event_state_localized";
      $this->order = "lower(event.title), lower(event.subtitle)";
      $this->join = "event.event_state_id = event_state_localized.event_state_id AND event_state_localized.language_id = {$this->get_language_id()}";

      $this->search['event_id']['type'] = 'SUBSELECT';
      $this->search['event_id']['data'] = 'INTEGER';
      $this->search['event_id']['query'] = 'event.event_id {OP} ({STRING})';
      $this->search['conference_id']['type'] = 'SIMPLE';
      $this->search['conference_id']['data'] = 'INTEGER';
      $this->search['conference_id']['query'] = 'event.conference_id {OP} {STRING}';
      $this->search['duration']['type'] = 'SIMPLE';
      $this->search['duration']['data'] = 'INTERVAL';
      $this->search['duration']['query'] = 'event.duration {OP} {STRING}';
      $this->search['status']['type'] = 'SIMPLE';
      $this->search['status']['data'] = 'INTEGER';
      $this->search['status']['query'] = 'event.event_state_id {OP} {STRING}';
      $this->search['keyword']['type'] = 'SUBSELECT';
      $this->search['keyword']['data'] = 'INTEGER';
      $this->search['keyword']['query'] = 'event_id IN (SELECT event_id FROM event_keyword WHERE keyword_id {OP} ({STRING}))';
      $this->search['type']['type'] = 'SIMPLE';
      $this->search['type']['data'] = 'INTEGER';
      $this->search['type']['query'] = 'event.event_type_id {OP} {STRING}';
      $this->search['team']['type'] = 'SIMPLE';
      $this->search['team']['data'] = 'INTEGER';
      $this->search['team']['query'] = 'event.team_id {OP} {STRING}';
      $this->search['track']['type'] = 'SIMPLE';
      $this->search['track']['data'] = 'INTEGER';
      $this->search['track']['query'] = 'event.conference_track_id {OP} {STRING}';
      $this->search['day']['type'] = 'SIMPLE';
      $this->search['day']['data'] = 'INTEGER';
      $this->search['day']['query'] = 'event.day {OP} {STRING}';
      $this->search['room']['type'] = 'SIMPLE';
      $this->search['room']['data'] = 'INTEGER';
      $this->search['room']['query'] = 'event.room_id {OP} {STRING}';
      $this->search['language']['type'] = 'SIMPLE';
      $this->search['language']['data'] = 'INTEGER';
      $this->search['language']['query'] = 'event.language_id {OP} {STRING}';
      $this->search['title']['type'] = 'SIMPLE';
      $this->search['title']['data'] = 'TEXT';
      $this->search['title']['query'] = '(event.title {OP} {STRING} OR event.subtitle {OP} {STRING})';
      $this->search['description']['type'] = 'SIMPLE';
      $this->search['description']['data'] = 'TEXT';
      $this->search['description']['query'] = '(event.abstract {OP} {STRING} OR event.description {OP} {STRING})';
      $this->search['coordinator']['type'] = 'SUBSELECT';
      $this->search['coordinator']['data'] = 'INTEGER';
      $this->search['coordinator']['query'] = "event.event_id IN (SELECT event_person.event_id FROM event_person, event_role WHERE event_person.event_role_id = event_role.event_role_id AND event_role.tag = 'coordinator' AND event_person.person_id {OP} ({STRING}))";
      $this->search['speaker']['type'] = 'SUBSELECT';
      $this->search['speaker']['data'] = 'INTEGER';
      $this->search['speaker']['query'] = "event.event_id IN (SELECT event_person.event_id FROM event_person, event_role WHERE event_person.event_role_id = event_role.event_role_id AND event_role.tag = 'speaker' AND event_person.person_id {OP} ({STRING}))";
      $this->search['attachment']['type'] = 'SUBSELECT';
      $this->search['attachment']['data'] = 'INTEGER';
      $this->search['attachment']['query'] = "event.event_id IN (SELECT event_attachment.event_id FROM event_attachment WHERE event_attachment.attachment_type_id {OP} ({STRING}))";

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
      $this->field['start_time']['type'] = 'INTERVAL';
      $this->field['start_time']['table'] = 'event';
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
      
      $this->field['event_state']['type'] = 'VARCHAR';
      $this->field['event_state']['table'] = 'event_state_localized';
      $this->field['event_state']['name'] = 'event_state_localized.name';
    
      parent::__construct($condition);
    }

  }

?>
