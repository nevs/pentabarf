<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in currency_localized.
*/

class Currency_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "currency_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['currency_id']['type'] = 'INTEGER';
    $this->field['currency_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['name']['not_null'] = true;
    $this->field['currency_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
