<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_interval.php');
require_once('../classes/database/datatypes/dt_smallint.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table event
class FUNC_EVENT_LOCALIZED extends DB_Base
{
   /// constructor of the class event
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event';
      $this->domain = 'event';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id'] = new DT_SERIAL( $this, 'event_id', array(), array() );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array() );
      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array() );
      $this->fields['title'] = new DT_VARCHAR( $this, 'title', array('length' => 128), array() );
      $this->fields['subtitle'] = new DT_VARCHAR( $this, 'subtitle', array('length' => 128), array() );
      $this->fields['conference_track_id'] = new DT_INTEGER( $this, 'conference_track_id', array(), array() );
      $this->fields['conference_track'] = new DT_VARCHAR( $this, 'title', array('length' => 64), array() );
      $this->fields['conference_track_tag'] = new DT_VARCHAR( $this, 'title', array('length' => 32), array() );
      $this->fields['team_id'] = new DT_INTEGER( $this, 'team_id', array(), array() );
      $this->fields['team'] = new DT_VARCHAR( $this, 'title', array('length' => 64), array() );
      $this->fields['team_tag'] = new DT_VARCHAR( $this, 'title', array('length' => 32), array() );
      $this->fields['event_type_id'] = new DT_INTEGER( $this, 'event_type_id', array(), array() );
      $this->fields['event_type'] = new DT_VARCHAR( $this, 'title', array('length' => 64), array() );
      $this->fields['event_type_tag'] = new DT_VARCHAR( $this, 'title', array('length' => 32), array() );
      $this->fields['duration'] = new DT_INTERVAL( $this, 'duration', array(), array() );
      $this->fields['event_state_id'] = new DT_INTEGER( $this, 'event_state_id', array(), array() );
      $this->fields['event_state'] = new DT_VARCHAR( $this, 'title', array('length' => 64), array() );
      $this->fields['event_state_tag'] = new DT_VARCHAR( $this, 'title', array('length' => 32), array() );
      $this->fields['language_id'] = new DT_INTEGER( $this, 'language_id', array(), array() );
      $this->fields['language'] = new DT_VARCHAR( $this, 'title', array('length' => 64), array() );
      $this->fields['room_id'] = new DT_INTEGER( $this, 'room_id', array(), array() );
      $this->fields['room'] = new DT_VARCHAR( $this, 'title', array('length' => 64), array() );
      $this->fields['room_tag'] = new DT_VARCHAR( $this, 'title', array('length' => 32), array() );
      $this->fields['day'] = new DT_SMALLINT( $this, 'day', array(), array() );
      $this->fields['start_time'] = new DT_INTERVAL( $this, 'start_time', array(), array() );
      $this->fields['abstract'] = new DT_TEXT( $this, 'abstract', array(), array() );
      $this->fields['description'] = new DT_TEXT( $this, 'description', array(), array() );
      $this->fields['resources'] = new DT_TEXT( $this, 'resources', array(), array() );
      $this->fields['f_public'] = new DT_BOOL( $this, 'f_public', array(), array() );
      $this->fields['f_paper'] = new DT_BOOL( $this, 'f_paper', array(), array() );
      $this->fields['f_slides'] = new DT_BOOL( $this, 'f_slides', array(), array() );
      $this->fields['f_conflict'] = new DT_BOOL( $this, 'f_conflict', array(), array() );
      $this->fields['f_deleted'] = new DT_BOOL( $this, 'f_deleted', array(), array() );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
   }

}

?>
