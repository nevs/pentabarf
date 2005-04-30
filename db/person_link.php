<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_link.
*/

class Person_Link extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_link";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_link_id']['type'] = 'SERIAL';
    $this->field['person_link_id']['not_null'] = true;
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['link_type_id']['type'] = 'INTEGER';
    $this->field['link_type_id']['not_null'] = true;
    $this->field['url']['type'] = 'VARCHAR';
    $this->field['url']['length'] = 1024;
    $this->field['url']['not_null'] = true;
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['length'] = 128;
    $this->field['description']['type'] = 'VARCHAR';
    $this->field['description']['length'] = 128;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['person_link_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
