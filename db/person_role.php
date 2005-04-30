<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_role.
*/

class Person_Role extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_role";
    $this->order = "";
    $this->domain = "roles";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['role_id']['type'] = 'INTEGER';
    $this->field['role_id']['not_null'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['role_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
