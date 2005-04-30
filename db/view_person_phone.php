<?php

require_once('view.php');

/**
 * Class for accessing, manipulating, creating and deleting records in person_phone.
*/

class View_Person_Phone extends View
{

  public function __construct($select = array())
  {
    $this->table = 'person_phone, phone_type';
    $this->order = 'person_phone.person_id, person_phone.rank';
    $this->domain = 'person';
    $this->join = 'person_phone.phone_type_id = phone_type.phone_type_id';
    $this->field['person_phone_id']['type'] = 'SERIAL';
    $this->field['person_phone_id']['table'] = 'person_phone';
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['table'] = 'person_phone';
    $this->field['phone_type_id']['type'] = 'INTEGER';
    $this->field['phone_type_id']['table'] = 'person_phone';
    $this->field['phone_number']['type'] = 'VARCHAR';
    $this->field['phone_number']['table'] = 'person_phone';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['rank']['table'] = 'person_phone';
    $this->field['phone_type_tag']['type'] = 'VARCHAR';
    $this->field['phone_type_tag']['name'] = 'phone_type.tag';
    parent::__construct($select);
  }

}

?>
