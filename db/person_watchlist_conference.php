<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_watchlist_conference.
*/

class Person_Watchlist_Conference extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_watchlist_conference";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['not_null'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['conference_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
