<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in currency.
*/

class Currency extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "currency";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['currency_id']['type'] = 'SERIAL';
    $this->field['currency_id']['not_null'] = true;
    $this->field['iso_4217_code']['type'] = 'CHAR';
    $this->field['iso_4217_code']['length'] = 3;
    $this->field['iso_4217_code']['not_null'] = true;
    $this->field['f_default']['type'] = 'BOOL';
    $this->field['f_default']['not_null'] = true;
    $this->field['f_default']['default'] = true;
    $this->field['f_visible']['type'] = 'BOOL';
    $this->field['f_visible']['not_null'] = true;
    $this->field['f_visible']['default'] = true;
    $this->field['f_preferred']['type'] = 'BOOL';
    $this->field['f_preferred']['not_null'] = true;
    $this->field['f_preferred']['default'] = true;
    $this->field['exchange_rate']['type'] = 'DECIMAL';
    $this->field['exchange_rate']['length'] = 15;
    $this->field['exchange_rate']['fraction'] = 5;
    $this->field['currency_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
