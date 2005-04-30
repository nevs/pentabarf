<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in country_localized.
*/

class Country_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "country_localized";
    $this->order = "country_localized.name";
    $this->domain = "localization";
    $this->field['country_id']['type'] = 'INTEGER';
    $this->field['country_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['name']['not_null'] = true;
    $this->field['country_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
