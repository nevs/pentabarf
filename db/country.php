<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in country.
*/

class Country extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "country";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['country_id']['type'] = 'SERIAL';
    $this->field['country_id']['not_null'] = true;
    $this->field['iso_3166_code']['type'] = 'CHAR';
    $this->field['iso_3166_code']['length'] = 2;
    $this->field['iso_3166_code']['not_null'] = true;
    $this->field['phone_prefix']['type'] = 'VARCHAR';
    $this->field['phone_prefix']['length'] = 8;
    $this->field['f_visible']['type'] = 'BOOL';
    $this->field['f_visible']['not_null'] = true;
    $this->field['f_visible']['default'] = true;
    $this->field['f_preferred']['type'] = 'BOOL';
    $this->field['f_preferred']['not_null'] = true;
    $this->field['f_preferred']['default'] = true;
    $this->field['country_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
