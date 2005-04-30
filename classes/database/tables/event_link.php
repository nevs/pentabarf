<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table event_link
class EVENT_LINK extends DB_BASE
{
   /// constructor of the class event_link
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_link';
      $this->domain = 'event_link';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id'] = new DT_INTEGER( $this, 'event_id', array(), array('NOT_NULL' => true) );
      $this->fields['title'] = new DT_VARCHAR( $this, 'title', array('length' => 128), array() );
      $this->fields['url'] = new DT_VARCHAR( $this, 'url', array('length' => 1024), array('NOT_NULL' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['link_type_id'] = new DT_INTEGER( $this, 'link_type_id', array(), array('NOT_NULL' => true) );
      $this->fields['description'] = new DT_VARCHAR( $this, 'description', array('length' => 128), array() );
      $this->fields['event_link_id'] = new DT_SERIAL( $this, 'event_link_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
