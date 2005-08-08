<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_rating.
*/

class Event_Rating extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_rating";
    $this->order = "";
    $this->domain = "rating";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['not_null'] = true;
    $this->field['relevance']['type'] = 'SMALLINT';
    $this->field['relevance_comment']['type'] = 'VARCHAR';
    $this->field['relevance_comment']['length'] = 128;
    $this->field['actuality']['type'] = 'SMALLINT';
    $this->field['actuality_comment']['type'] = 'VARCHAR';
    $this->field['actuality_comment']['length'] = 128;
    $this->field['acceptance']['type'] = 'SMALLINT';
    $this->field['acceptance_comment']['type'] = 'VARCHAR';
    $this->field['acceptance_comment']['length'] = 128;
    $this->field['remark']['type'] = 'TEXT';
    $this->field['eval_time']['type'] = 'TIMESTAMP';
    $this->field['eval_time']['not_null'] = true;
    $this->field['eval_time']['default'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['event_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
