<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in conference_person.
*/

class Conference_Person extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "conference_person";
    $this->order = "";
    $this->domain = "conference";
    $this->field['conference_person_id']['type'] = 'SERIAL';
    $this->field['conference_person_id']['not_null'] = true;
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['not_null'] = true;
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['conference_role_id']['type'] = 'INTEGER';
    $this->field['conference_role_id']['not_null'] = true;
    $this->field['remark']['type'] = 'TEXT';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['conference_person_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
