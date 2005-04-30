<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_time.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_date.php');
require_once('../classes/database/datatypes/dt_interval.php');
require_once('../classes/database/datatypes/dt_smallint.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table conference
class CONFERENCE extends DB_BASE
{
   /// constructor of the class conference
   public function __construct()
   {
      parent::__construct();
      $this->table = 'conference';
      $this->domain = 'conference';
      $this->limit = 0;
      $this->order = '';

      $this->fields['f_deleted'] = new DT_BOOL( $this, 'f_deleted', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['city'] = new DT_VARCHAR( $this, 'city', array('length' => 64), array() );
      $this->fields['start_date'] = new DT_DATE( $this, 'start_date', array(), array('NOT_NULL' => true) );
      $this->fields['day_change'] = new DT_TIME( $this, 'day_change', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['timeslot_duration'] = new DT_INTERVAL( $this, 'timeslot_duration', array(), array() );
      $this->fields['secondary_language_id'] = new DT_INTEGER( $this, 'secondary_language_id', array(), array() );
      $this->fields['days'] = new DT_SMALLINT( $this, 'days', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['max_timeslot_duration'] = new DT_INTEGER( $this, 'max_timeslot_duration', array(), array() );
      $this->fields['currency_id'] = new DT_INTEGER( $this, 'currency_id', array(), array() );
      $this->fields['title'] = new DT_VARCHAR( $this, 'title', array('length' => 128), array('NOT_NULL' => true) );
      $this->fields['export_css_file'] = new DT_VARCHAR( $this, 'export_css_file', array('length' => 256), array() );
      $this->fields['acronym'] = new DT_VARCHAR( $this, 'acronym', array('length' => 16), array('NOT_NULL' => true) );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
      $this->fields['country_id'] = new DT_INTEGER( $this, 'country_id', array(), array() );
      $this->fields['feedback_base_url'] = new DT_VARCHAR( $this, 'feedback_base_url', array('length' => 256), array() );
      $this->fields['export_base_url'] = new DT_VARCHAR( $this, 'export_base_url', array('length' => 256), array() );
      $this->fields['primary_language_id'] = new DT_INTEGER( $this, 'primary_language_id', array(), array() );
      $this->fields['subtitle'] = new DT_VARCHAR( $this, 'subtitle', array('length' => 128), array() );
      $this->fields['release'] = new DT_VARCHAR( $this, 'release', array('length' => 32), array() );
      $this->fields['venue'] = new DT_VARCHAR( $this, 'venue', array('length' => 64), array() );
      $this->fields['conference_id'] = new DT_SERIAL( $this, 'conference_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['time_zone_id'] = new DT_INTEGER( $this, 'time_zone_id', array(), array() );
   }

}

?>
