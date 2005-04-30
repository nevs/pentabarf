<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in mime_type.
*/

class MIME_Type extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "mime_type";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['mime_type_id']['type'] = 'SERIAL';
    $this->field['mime_type_id']['not_null'] = true;
    $this->field['mime_type']['type'] = 'VARCHAR';
    $this->field['mime_type']['length'] = 128;
    $this->field['mime_type']['not_null'] = true;
    $this->field['file_extension']['type'] = 'VARCHAR';
    $this->field['file_extension']['length'] = 16;
    $this->field['f_image']['type'] = 'BOOL';
    $this->field['f_image']['not_null'] = true;
    $this->field['f_image']['default'] = true;
    $this->field['mime_type_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
