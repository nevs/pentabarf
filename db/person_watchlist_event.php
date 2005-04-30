<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_watchlist_event.
*/

class Person_Watchlist_Event extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_watchlist_event";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['not_null'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['event_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
