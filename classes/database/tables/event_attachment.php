<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_bytea.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table event_attachment
class EVENT_ATTACHMENT extends DB_BASE
{
   /// constructor of the class event_attachment
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_attachment';
      $this->domain = 'event_attachment';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id'] = new DT_INTEGER( $this, 'event_id', array(), array('NOT_NULL' => true) );
      $this->fields['event_attachment_id'] = new DT_SERIAL( $this, 'event_attachment_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['f_public'] = new DT_BOOL( $this, 'f_public', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['title'] = new DT_VARCHAR( $this, 'title', array('length' => 64), array() );
      $this->fields['mime_type_id'] = new DT_INTEGER( $this, 'mime_type_id', array(), array('NOT_NULL' => true) );
      $this->fields['attachment_type_id'] = new DT_INTEGER( $this, 'attachment_type_id', array(), array('NOT_NULL' => true) );
      $this->fields['filename'] = new DT_VARCHAR( $this, 'filename', array('length' => 256), array() );
      $this->fields['data'] = new DT_BYTEA( $this, 'data', array(), array('NOT_NULL' => true) );
   }

}

?>
