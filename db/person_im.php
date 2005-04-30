<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_im.
*/

class Person_IM extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_im";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_im_id']['type'] = 'SERIAL';
    $this->field['person_im_id']['not_null'] = true;
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['im_type_id']['type'] = 'INTEGER';
    $this->field['im_type_id']['not_null'] = true;
    $this->field['im_address']['type'] = 'VARCHAR';
    $this->field['im_address']['length'] = 128;
    $this->field['im_address']['not_null'] = true;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['person_im_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
