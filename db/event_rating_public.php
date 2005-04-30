<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_rating_public.
*/

class Event_Rating_Public extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_rating_public";
    $this->order = "";
    $this->domain = "public";
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['not_null'] = true;
    $this->field['participant_knowledge']['type'] = 'SMALLINT';
    $this->field['topic_importance']['type'] = 'SMALLINT';
    $this->field['content_quality']['type'] = 'SMALLINT';
    $this->field['presentation_quality']['type'] = 'SMALLINT';
    $this->field['audience_involvement']['type'] = 'SMALLINT';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['eval_time']['type'] = 'TIMESTAMP';
    $this->field['eval_time']['not_null'] = true;
    $this->field['eval_time']['default'] = true;
    $this->field['rater_ip']['type'] = 'INET';
    $this->field['event_id']['primary_key'] = true;
    $this->field['eval_time']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
