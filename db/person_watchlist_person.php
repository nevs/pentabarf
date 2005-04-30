<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_watchlist_person.
*/

class Person_Watchlist_Person extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_watchlist_person";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['watched_person_id']['type'] = 'INTEGER';
    $this->field['watched_person_id']['not_null'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['watched_person_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
