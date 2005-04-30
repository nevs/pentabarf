<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_serial.php');

/// class for accessing and manipulating content of table team
class TEAM extends DB_BASE
{
   /// constructor of the class team
   public function __construct()
   {
      parent::__construct();
      $this->table = 'team';
      $this->domain = 'team';
      $this->limit = 0;
      $this->order = '';

      $this->fields['team_id'] = new DT_SERIAL( $this, 'team_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['tag'] = new DT_VARCHAR( $this, 'tag', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['rank'] = new DT_INTEGER( $this, 'rank', array(), array() );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array('NOT_NULL' => true) );
   }

}

?>
