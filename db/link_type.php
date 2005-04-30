<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in link_type.
*/

class Link_Type extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "link_type";
    $this->order = "";
    $this->domain = "valuelist";
    $this->field['link_type_id']['type'] = 'SERIAL';
    $this->field['link_type_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['url_prefix']['type'] = 'VARCHAR';
    $this->field['url_prefix']['length'] = 1024;
    $this->field['f_public']['type'] = 'BOOL';
    $this->field['f_public']['not_null'] = true;
    $this->field['f_public']['default'] = true;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['link_type_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
