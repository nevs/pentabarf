<?php

require_once("view.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_im.
*/

class View_Person_IM extends View
{

  public function __construct($select = array())
  {
    $this->table = "person_im, im_type";
    $this->order = "person_im.person_id, person_im.rank";
    $this->domain = "person";
    $this->join = "person_im.im_type_id = im_type.im_type_id";
    $this->field['person_im_id']['type'] = 'SERIAL';
    $this->field['person_im_id']['table'] = 'person_im';
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['table'] = 'person_im';
    $this->field['im_type_id']['type'] = 'INTEGER';
    $this->field['im_type_id']['table'] = 'person_im';
    $this->field['im_address']['type'] = 'VARCHAR';
    $this->field['im_address']['table'] = 'person_im';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['rank']['table'] = 'person_im';
    $this->field['im_type_tag']['type'] = 'VARCHAR';
    $this->field['im_type_tag']['name'] = 'im_type.tag';
    parent::__construct($select);
  }

}

?>
