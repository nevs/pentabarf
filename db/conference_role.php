<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in conference_role.
*/

class Conference_Role extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "conference_role";
    $this->order = "";
    $this->domain = "conference";
    $this->field['conference_role_id']['type'] = 'SERIAL';
    $this->field['conference_role_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['conference_role_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
