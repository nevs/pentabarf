<?php

require_once('view.php');

/**
 * Class for accessing, manipulating, creating and deleting records in event_rating_public.
*/

class View_Event_Rating_Public extends View
{

  public function __construct($select = array())
  {
    $this->table = 'event_rating_public, event';
    $this->order = '';
    $this->domain = 'public';
    $this->join = 'event_rating_public.event_id = event.event_id';
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['table'] = 'event_rating_public';
    $this->field['participant_knowledge']['type'] = 'SMALLINT';
    $this->field['participant_knowledge']['table'] = 'event_rating_public';
    $this->field['topic_importance']['type'] = 'SMALLINT';
    $this->field['topic_importance']['table'] = 'event_rating_public';
    $this->field['content_quality']['type'] = 'SMALLINT';
    $this->field['content_quality']['table'] = 'event_rating_public';
    $this->field['presentation_quality']['type'] = 'SMALLINT';
    $this->field['presentation_quality']['table'] = 'event_rating_public';
    $this->field['audience_involvement']['type'] = 'SMALLINT';
    $this->field['audience_involvement']['table'] = 'event_rating_public';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['remark']['table'] = 'event_rating_public';
    $this->field['eval_time']['type'] = 'TIMESTAMP';
    $this->field['eval_time']['table'] = 'event_rating_public';
    $this->field['rater_ip']['type'] = 'INET';
    $this->field['rater_ip']['table'] = 'event_rating_public';
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['table'] = 'event';
    parent::__construct($select);
  }

}

?>
