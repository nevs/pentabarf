<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in link_type_localized.
*/

class Link_Type_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "link_type_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['link_type_id']['type'] = 'INTEGER';
    $this->field['link_type_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['name']['not_null'] = true;
    $this->field['link_type_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
