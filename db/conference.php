<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in conference.
*/

class Conference extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "conference";
    $this->order = "conference.acronym";
    $this->domain = "conference";
    $this->field['conference_id']['type'] = 'SERIAL';
    $this->field['conference_id']['not_null'] = true;
    $this->field['acronym']['type'] = 'VARCHAR';
    $this->field['acronym']['length'] = 16;
    $this->field['acronym']['not_null'] = true;
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['length'] = 128;
    $this->field['title']['not_null'] = true;
    $this->field['subtitle']['type'] = 'VARCHAR';
    $this->field['subtitle']['length'] = 128;
    $this->field['start_date']['type'] = 'DATE';
    $this->field['start_date']['not_null'] = true;
    $this->field['days']['type'] = 'SMALLINT';
    $this->field['days']['not_null'] = true;
    $this->field['days']['default'] = true;
    $this->field['venue']['type'] = 'VARCHAR';
    $this->field['venue']['length'] = 64;
    $this->field['city']['type'] = 'VARCHAR';
    $this->field['city']['length'] = 64;
    $this->field['country_id']['type'] = 'INTEGER';
    $this->field['time_zone_id']['type'] = 'INTEGER';
    $this->field['currency_id']['type'] = 'INTEGER';
    $this->field['primary_language_id']['type'] = 'INTEGER';
    $this->field['secondary_language_id']['type'] = 'INTEGER';
    $this->field['timeslot_duration']['type'] = 'INTERVAL';
    $this->field['max_timeslot_duration']['type'] = 'INTEGER';
    $this->field['day_change']['type'] = 'TIME';
    $this->field['day_change']['not_null'] = true;
    $this->field['day_change']['default'] = true;
    $this->field['remark']['type'] = 'TEXT';
    $this->field['f_deleted']['type'] = 'BOOL';
    $this->field['f_deleted']['not_null'] = true;
    $this->field['f_deleted']['default'] = true;
    $this->field['release']['type'] = 'VARCHAR';
    $this->field['release']['length'] = 32;
    $this->field['export_base_url']['type'] = 'VARCHAR';
    $this->field['export_base_url']['length'] = 256;
    $this->field['export_css_file']['type'] = 'VARCHAR';
    $this->field['export_css_file']['length'] = 256;
    $this->field['feedback_base_url']['type'] = 'VARCHAR';
    $this->field['feedback_base_url']['length'] = 256;
    $this->field['conference_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
