<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_char.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table country
class COUNTRY extends DB_BASE
{
   /// constructor of the class country
   public function __construct()
   {
      parent::__construct();
      $this->table = 'country';
      $this->domain = 'country';
      $this->limit = 0;
      $this->order = '';

      $this->fields['f_preferred'] = new DT_BOOL( $this, 'f_preferred', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['iso_3166_code'] = new DT_CHAR( $this, 'iso_3166_code', array('length' => 2), array('NOT_NULL' => true) );
      $this->fields['f_visible'] = new DT_BOOL( $this, 'f_visible', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['phone_prefix'] = new DT_VARCHAR( $this, 'phone_prefix', array('length' => 8), array() );
      $this->fields['country_id'] = new DT_SERIAL( $this, 'country_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
