<?php

  require_once('../db/procedure.php');

  class Conflict_Event_No_Coordinator extends Procedure
  {
    public function __construct()
    {
      $this->table = 'conflict_event_no_coordinator';
      
      $this->parameter['conference_id'] = 'INTEGER';

      $this->distinct = array();

      $this->field['event_id']['type'] = 'INTEGER'; 
      $this->field['title']['type'] = 'VARCHAR'; 
      $this->field['subtitle']['type'] = 'VARCHAR'; 
    }

  }

?>
