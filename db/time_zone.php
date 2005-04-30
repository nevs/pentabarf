<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in time_zone.
*/

class Time_Zone extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "time_zone";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['time_zone_id']['type'] = 'SERIAL';
    $this->field['time_zone_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['f_visible']['type'] = 'BOOL';
    $this->field['f_visible']['not_null'] = true;
    $this->field['f_visible']['default'] = true;
    $this->field['f_preferred']['type'] = 'BOOL';
    $this->field['f_preferred']['not_null'] = true;
    $this->field['f_preferred']['default'] = true;
    $this->field['time_zone_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
