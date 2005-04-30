<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in role.
*/

class Role extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "role";
    $this->order = "rank";
    $this->domain = "role";
    $this->field['role_id']['type'] = 'SERIAL';
    $this->field['role_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['role_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
