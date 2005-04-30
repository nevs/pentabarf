<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table mime_type
class MIME_TYPE extends DB_BASE
{
   /// constructor of the class mime_type
   public function __construct()
   {
      parent::__construct();
      $this->table = 'mime_type';
      $this->domain = 'mime_type';
      $this->limit = 0;
      $this->order = '';

      $this->fields['f_image'] = new DT_BOOL( $this, 'f_image', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['mime_type_id'] = new DT_SERIAL( $this, 'mime_type_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['mime_type'] = new DT_VARCHAR( $this, 'mime_type', array('length' => 128), array('NOT_NULL' => true) );
      $this->fields['file_extension'] = new DT_VARCHAR( $this, 'file_extension', array('length' => 16), array() );
   }

}

?>
