<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_language.
*/

class Person_Language extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_language";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['person_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
