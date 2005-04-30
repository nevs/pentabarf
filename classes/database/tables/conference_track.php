<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table conference_track
class CONFERENCE_TRACK extends DB_BASE
{
   /// constructor of the class conference_track
   public function __construct()
   {
      parent::__construct();
      $this->table = 'conference_track';
      $this->domain = 'conference_track';
      $this->limit = 0;
      $this->order = '';

      $this->fields['conference_track_id'] = new DT_SERIAL( $this, 'conference_track_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array('NOT_NULL' => true) );
   }

}

?>
