<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table conference_person
class CONFERENCE_PERSON extends DB_BASE
{
   /// constructor of the class conference_person
   public function __construct()
   {
      parent::__construct();
      $this->table = 'conference_person';
      $this->domain = 'conference_person';
      $this->limit = 0;
      $this->order = '';

      $this->fields['conference_role_id'] = new DT_INTEGER( $this, 'conference_role_id', array(), array('NOT_NULL' => true) );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['conference_person_id'] = new DT_SERIAL( $this, 'conference_person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array('NOT_NULL' => true) );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true) );
   }

}

?>
