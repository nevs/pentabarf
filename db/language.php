<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in language.
*/

class Language extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "language";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['language_id']['type'] = 'SERIAL';
    $this->field['language_id']['not_null'] = true;
    $this->field['iso_639_code']['type'] = 'CHAR';
    $this->field['iso_639_code']['length'] = 3;
    $this->field['iso_639_code']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['f_default']['type'] = 'BOOL';
    $this->field['f_default']['not_null'] = true;
    $this->field['f_default']['default'] = true;
    $this->field['f_localized']['type'] = 'BOOL';
    $this->field['f_localized']['not_null'] = true;
    $this->field['f_localized']['default'] = true;
    $this->field['f_visible']['type'] = 'BOOL';
    $this->field['f_visible']['not_null'] = true;
    $this->field['f_visible']['default'] = true;
    $this->field['f_preferred']['type'] = 'BOOL';
    $this->field['f_preferred']['not_null'] = true;
    $this->field['f_preferred']['default'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
