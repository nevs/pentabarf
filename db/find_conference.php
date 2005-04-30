<?php

require_once("find.php");

/**
 * Class for accessing, manipulating, creating and deleting records in conference.
*/

class Find_Conference extends Find 
{

  public function __construct($select = array())
  {
    $this->table = "conference";
    $this->order = "conference.acronym";
    $this->domain = "conference";
    
    $this->search['conference_id']['type'] = 'SUBSELECT';
    $this->search['conference_id']['data'] = 'INTEGER';
    $this->search['conference_id']['query'] = 'conference.conference_id {OP} ({STRING})';
    $this->search['title']['type'] = 'SIMPLE';
    $this->search['title']['data'] = 'TEXT';
    $this->search['title']['query'] = '(conference.title ILIKE {STRING} OR conference.subtitle ILIKE {STRING} OR conference.acronym ILIKE {STRING})';
    
    $this->field['conference_id']['type'] = 'SERIAL';
    $this->field['conference_id']['table'] = 'conference';
    $this->field['acronym']['type'] = 'VARCHAR';
    $this->field['acronym']['table'] = 'conference';
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['table'] = 'conference';
    $this->field['subtitle']['type'] = 'VARCHAR';
    $this->field['subtitle']['table'] = 'conference';
    $this->field['start_date']['type'] = 'DATE';
    $this->field['start_date']['table'] = 'conference';
    $this->field['days']['type'] = 'SMALLINT';
    $this->field['days']['table'] = 'conference';
    $this->field['venue']['type'] = 'VARCHAR';
    $this->field['venue']['table'] = 'conference';
    $this->field['city']['type'] = 'VARCHAR';
    $this->field['city']['table'] = 'conference';
    $this->field['country_id']['type'] = 'INTEGER';
    $this->field['country_id']['table'] = 'conference';
    $this->field['time_zone_id']['type'] = 'INTEGER';
    $this->field['time_zone_id']['table'] = 'conference';
    $this->field['currency_id']['type'] = 'INTEGER';
    $this->field['currency_id']['table'] = 'conference';
    $this->field['primary_language_id']['type'] = 'INTEGER';
    $this->field['primary_language_id']['table'] = 'conference';
    $this->field['secondary_language_id']['type'] = 'INTEGER';
    $this->field['secondary_language_id']['table'] = 'conference';
    $this->field['timeslot_duration']['type'] = 'INTERVAL';
    $this->field['timeslot_duration']['table'] = 'conference';
    $this->field['max_timeslot_duration']['type'] = 'INTEGER';
    $this->field['max_timeslot_duration']['table'] = 'conference';
    $this->field['day_change']['type'] = 'TIME';
    $this->field['day_change']['table'] = 'conference';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['remark']['table'] = 'conference';
    $this->field['f_deleted']['type'] = 'BOOL';
    $this->field['f_deleted']['table'] = 'conference';
    $this->field['release']['type'] = 'VARCHAR';
    $this->field['release']['table'] = 'conference';
    parent::__construct($select);
  }

}

?>
