<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_transaction.
*/

class Person_Transaction extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_transaction";
    $this->order = "changed_when DESC";
    $this->domain = "person";
    $this->limit = 1;
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['changed_when']['type'] = 'EXACTTIMESTAMP';
    $this->field['changed_when']['not_null'] = true;
    $this->field['changed_when']['default'] = true;
    $this->field['changed_when']['primary_key'] = true;
    $this->field['changed_by']['type'] = 'INTEGER';
    $this->field['changed_by']['not_null'] = true;
    $this->field['f_create']['type'] = 'BOOL';
    $this->field['f_create']['not_null'] = true;
    $this->field['f_create']['default'] = true;
    parent::__construct($select);
  }

}

?>
