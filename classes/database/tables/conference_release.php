<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_timestamp.php');

/// class for accessing and manipulating content of table conference_release
class CONFERENCE_RELEASE extends DB_BASE
{
   /// constructor of the class conference_release
   public function __construct()
   {
      parent::__construct();
      $this->table = 'conference_release';
      $this->domain = 'conference_release';
      $this->limit = 0;
      $this->order = '';

      $this->fields['release_tag'] = new DT_VARCHAR( $this, 'release_tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['description'] = new DT_VARCHAR( $this, 'description', array('length' => 128), array() );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array('NOT_NULL' => true) );
      $this->fields['release_id'] = new DT_SERIAL( $this, 'release_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['release_date'] = new DT_TIMESTAMP( $this, 'release_date', array('precision' => 0), array('DEFAULT' => true, 'NOT_NULL' => true) );
   }

}

?>
