<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in keyword_localized.
*/

class Keyword_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "keyword_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['keyword_id']['type'] = 'INTEGER';
    $this->field['keyword_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['name']['not_null'] = true;
    $this->field['keyword_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
