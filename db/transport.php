<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in transport.
*/

class Transport extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "transport";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['transport_id']['type'] = 'SERIAL';
    $this->field['transport_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['transport_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
