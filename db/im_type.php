<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in im_type.
*/

class IM_Type extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "im_type";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['im_type_id']['type'] = 'SERIAL';
    $this->field['im_type_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['scheme']['type'] = 'VARCHAR';
    $this->field['scheme']['length'] = 32;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['im_type_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
