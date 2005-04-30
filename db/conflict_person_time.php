<?php

  require_once('../db/procedure.php');

  class Conflict_Person_Time extends Procedure
  {
    public function __construct()
    {
      $this->table = 'conflict_person_time';
      
      $this->parameter['conference_id'] = 'INTEGER';

      $this->distinct = array('event_id1', 'event_id2');

      $this->field['person_id']['type'] = 'INTEGER'; 
      $this->field['name']['type'] = 'VARCHAR'; 
      $this->field['event_id1']['type'] = 'INTEGER'; 
      $this->field['title1']['type'] = 'VARCHAR'; 
      $this->field['subtitle1']['type'] = 'VARCHAR'; 
      $this->field['event_id2']['type'] = 'INTEGER'; 
      $this->field['title2']['type'] = 'VARCHAR'; 
      $this->field['subtitle2']['type'] = 'VARCHAR'; 
    }

  }

?>
