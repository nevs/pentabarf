<?php

require_once("view.php");

/**
* Class for accessing, manipulating, creating and deleting records in event_person.
*/

class View_Person_Travel extends View
{
  public function __construct($select = array())
  {
    $this->distinct = "";
    $this->table = "view_person INNER JOIN event_person USING (person_id) INNER JOIN event USING (event_id) INNER JOIN event_state USING (event_state_id)";
    $this->domain = "person";
    $this->order = "name";
    $this->join = "";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['name']['type'] = 'TEXT';
    $this->field['conference_id']['type'] = 'INTEGER';
    
    parent::__construct($select);
   
  }

}

?>
