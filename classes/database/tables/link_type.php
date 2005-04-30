<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table link_type
class LINK_TYPE extends DB_BASE
{
   /// constructor of the class link_type
   public function __construct()
   {
      parent::__construct();
      $this->table = 'link_type';
      $this->domain = 'link_type';
      $this->limit = 0;
      $this->order = '';

      $this->fields['f_public'] = new DT_BOOL( $this, 'f_public', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['link_type_id'] = new DT_SERIAL( $this, 'link_type_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['url_prefix'] = new DT_VARCHAR( $this, 'url_prefix', array('length' => 1024), array() );
   }

}

?>
