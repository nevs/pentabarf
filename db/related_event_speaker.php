<?php

  require_once('../db/procedure.php');

  class Related_Event_Speaker extends Procedure
  {
    public function __construct()
    {
      $this->table = 'related_event_speaker';
      
      $this->parameter['event_id'] = 'INTEGER';

      $this->distinct = array();

      $this->field['event_id']['type'] = 'INTEGER'; 
      $this->field['title']['type'] = 'VARCHAR'; 
      $this->field['subtitle']['type'] = 'VARCHAR'; 
      $this->field['day']['type'] = 'INTEGER'; 
      $this->field['start_time']['type'] = 'TIME'; 
      $this->field['room_id']['type'] = 'INTEGER';
      $this->field['event_state_id']['type'] = 'INTEGER';
      $this->field['conference_track_id']['type'] = 'INTEGER';

    }

  }

?>
