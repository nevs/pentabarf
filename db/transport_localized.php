<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in transport_localized.
*/

class Transport_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "transport_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['transport_id']['type'] = 'INTEGER';
    $this->field['transport_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['name']['not_null'] = true;
    $this->field['transport_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
