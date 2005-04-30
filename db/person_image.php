<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_image.
*/

class Person_Image extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_image";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['mime_type_id']['type'] = 'INTEGER';
    $this->field['mime_type_id']['not_null'] = true;
    $this->field['f_public']['type'] = 'BOOL';
    $this->field['f_public']['not_null'] = true;
    $this->field['f_public']['default'] = true;
    $this->field['image']['type'] = 'BYTEA';
    $this->field['image']['not_null'] = true;
    $this->field['person_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
