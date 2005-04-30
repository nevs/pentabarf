<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_phone.
*/

class Person_Phone extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_phone";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_phone_id']['type'] = 'SERIAL';
    $this->field['person_phone_id']['not_null'] = true;
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['phone_type_id']['type'] = 'INTEGER';
    $this->field['phone_type_id']['not_null'] = true;
    $this->field['phone_number']['type'] = 'VARCHAR';
    $this->field['phone_number']['length'] = 32;
    $this->field['phone_number']['not_null'] = true;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['person_phone_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
