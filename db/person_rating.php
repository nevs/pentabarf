<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_rating.
*/

class Person_Rating extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_rating";
    $this->order = "";
    $this->domain = "rating";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['evaluator_id']['type'] = 'INTEGER';
    $this->field['evaluator_id']['not_null'] = true;
    $this->field['speaker_quality']['type'] = 'SMALLINT';
    $this->field['quality_comment']['type'] = 'VARCHAR';
    $this->field['quality_comment']['length'] = 128;
    $this->field['competence']['type'] = 'SMALLINT';
    $this->field['competence_comment']['type'] = 'VARCHAR';
    $this->field['competence_comment']['length'] = 128;
    $this->field['remark']['type'] = 'TEXT';
    $this->field['eval_time']['type'] = 'EXACTTIMESTAMP';
    $this->field['eval_time']['not_null'] = true;
    $this->field['eval_time']['default'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['evaluator_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
