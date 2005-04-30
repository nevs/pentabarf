<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');

/// class for accessing and manipulating content of table conference_localized
class CONFERENCE_LOCALIZED extends DB_BASE
{
   /// constructor of the class conference_localized
   public function __construct()
   {
      parent::__construct();
      $this->table = 'conference_localized';
      $this->domain = 'conference_localized';
      $this->limit = 0;
      $this->order = '';

      $this->fields['description'] = new DT_TEXT( $this, 'description', array(), array('NOT_NULL' => true) );
      $this->fields['language_id'] = new DT_INTEGER( $this, 'language_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
