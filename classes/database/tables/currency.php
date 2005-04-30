<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_char.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_decimal.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table currency
class CURRENCY extends DB_BASE
{
   /// constructor of the class currency
   public function __construct()
   {
      parent::__construct();
      $this->table = 'currency';
      $this->domain = 'currency';
      $this->limit = 0;
      $this->order = '';

      $this->fields['f_preferred'] = new DT_BOOL( $this, 'f_preferred', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['f_default'] = new DT_BOOL( $this, 'f_default', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['currency_id'] = new DT_SERIAL( $this, 'currency_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['f_visible'] = new DT_BOOL( $this, 'f_visible', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['iso_4217_code'] = new DT_CHAR( $this, 'iso_4217_code', array('length' => 3), array('NOT_NULL' => true) );
      $this->fields['exchange_rate'] = new DT_DECIMAL( $this, 'exchange_rate', array('scale' => 5, 'precision' => 15), array() );
   }

}

?>
