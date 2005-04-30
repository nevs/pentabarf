<?php

  require_once('../db/procedure.php');

  class Conflict_Person_Event_Language extends Procedure
  {
    public function __construct()
    {
      $this->table = 'conflict_person_event_language';
      
      $this->parameter['conference_id'] = 'INTEGER';

      $this->distinct = array();

      $this->field['person_id']['type'] = 'INTEGER'; 
      $this->field['name']['type'] = 'VARCHAR'; 
      $this->field['event_id']['type'] = 'INTEGER'; 
      $this->field['title']['type'] = 'VARCHAR'; 
      $this->field['subtitle']['type'] = 'VARCHAR'; 
    }

  }

?>
