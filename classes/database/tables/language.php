<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_char.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table language
class LANGUAGE extends DB_BASE
{
   /// constructor of the class language
   public function __construct()
   {
      parent::__construct();
      $this->table = 'language';
      $this->domain = 'language';
      $this->limit = 0;
      $this->order = '';

      $this->fields['f_preferred'] = new DT_BOOL( $this, 'f_preferred', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['f_default'] = new DT_BOOL( $this, 'f_default', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['f_visible'] = new DT_BOOL( $this, 'f_visible', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['f_localized'] = new DT_BOOL( $this, 'f_localized', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['language_id'] = new DT_SERIAL( $this, 'language_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['iso_639_code'] = new DT_CHAR( $this, 'iso_639_code', array('length' => 3), array('NOT_NULL' => true) );
   }

}

?>
