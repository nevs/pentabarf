<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event.
*/

class Event extends Entity
{

  public function __construct($select = array())
  {
    $this->table = 'event';
    $this->order = 'lower(event.title), lower(event.subtitle)'; 
    $this->domain = 'event';
    $this->field['event_id']['type'] = 'SERIAL';
    $this->field['event_id']['not_null'] = true;
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['length'] = 128;
    $this->field['title']['not_null'] = true;
    $this->field['subtitle']['type'] = 'VARCHAR';
    $this->field['subtitle']['length'] = 128;
    $this->field['conference_track_id']['type'] = 'INTEGER';
    $this->field['team_id']['type'] = 'INTEGER';
    $this->field['event_type_id']['type'] = 'INTEGER';
    $this->field['duration']['type'] = 'INTERVAL';
    $this->field['event_state_id']['type'] = 'INTEGER';
    $this->field['event_state_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['room_id']['type'] = 'INTEGER';
    $this->field['day']['type'] = 'SMALLINT';
    $this->field['start_time']['type'] = 'INTERVAL';
    $this->field['abstract']['type'] = 'TEXT';
    $this->field['description']['type'] = 'TEXT';
    $this->field['resources']['type'] = 'TEXT';
    $this->field['f_public']['type'] = 'BOOL';
    $this->field['f_public']['not_null'] = true;
    $this->field['f_public']['default'] = true;
    $this->field['f_paper']['type'] = 'BOOL';
    $this->field['f_paper']['not_null'] = true;
    $this->field['f_paper']['default'] = true;
    $this->field['f_slides']['type'] = 'BOOL';
    $this->field['f_slides']['not_null'] = true;
    $this->field['f_slides']['default'] = true;
    $this->field['f_conflict']['type'] = 'BOOL';
    $this->field['f_conflict']['not_null'] = true;
    $this->field['f_conflict']['default'] = true;
    $this->field['f_deleted']['type'] = 'BOOL';
    $this->field['f_deleted']['not_null'] = true;
    $this->field['f_deleted']['default'] = true;
    $this->field['remark']['type'] = 'TEXT';
    $this->field['event_id']['primary_key'] = true;
    parent::__construct($select);
  }

  public function get_duration($cond = array())
  {
    return $this->select_single("sum", "SELECT sum(event.duration) AS sum FROM {$this->table} {$this->compile_where($cond)}");
  }

}

?>
