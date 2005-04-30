<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_bytea.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table person_image
class PERSON_IMAGE extends DB_BASE
{
   /// constructor of the class person_image
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_image';
      $this->domain = 'person_image';
      $this->limit = 0;
      $this->order = '';

      $this->fields['f_public'] = new DT_BOOL( $this, 'f_public', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['mime_type_id'] = new DT_INTEGER( $this, 'mime_type_id', array(), array('NOT_NULL' => true) );
      $this->fields['image'] = new DT_BYTEA( $this, 'image', array(), array('NOT_NULL' => true) );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
   }

}

?>
