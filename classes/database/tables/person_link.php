<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table person_link
class PERSON_LINK extends DB_BASE
{
   /// constructor of the class person_link
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_link';
      $this->domain = 'person_link';
      $this->limit = 0;
      $this->order = '';

      $this->fields['person_link_id'] = new DT_SERIAL( $this, 'person_link_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['title'] = new DT_VARCHAR( $this, 'title', array('length' => 128), array() );
      $this->fields['url'] = new DT_VARCHAR( $this, 'url', array('length' => 1024), array('NOT_NULL' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['link_type_id'] = new DT_INTEGER( $this, 'link_type_id', array(), array('NOT_NULL' => true) );
      $this->fields['description'] = new DT_VARCHAR( $this, 'description', array('length' => 128), array() );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true) );
   }

}

?>
