<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in conference_image.
*/

class Conference_Image extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "conference_image";
    $this->order = "";
    $this->domain = "conference";
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['not_null'] = true;
    $this->field['mime_type_id']['type'] = 'INTEGER';
    $this->field['mime_type_id']['not_null'] = true;
    $this->field['image']['type'] = 'BYTEA';
    $this->field['image']['not_null'] = true;
    $this->field['conference_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
