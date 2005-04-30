<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_keyword.
*/

class Person_Keyword extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_keyword";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['keyword_id']['type'] = 'INTEGER';
    $this->field['keyword_id']['not_null'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['keyword_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
