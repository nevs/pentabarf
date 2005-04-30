<?php

require_once('../classes/database/datatypes/dt_base.php');
require_once('../classes/exception/db_critical.php');

/// class for varchar values
class DT_VARCHAR extends DT_BASE
{

   /// constructor
   public function __construct( $parent, $name, $parameter = array(), $properties = array() )
   {
      parent::__construct( $parent, $name, $parameter, $properties ); 
      if ( $this->parameter['length'] <= 0 )
      {
         throw new DB_Critical('length must be positive and above zero.');
      }
   }

   /// set the value
   public function set( $value )
   {
      $this->value = substr( str_replace( '\\', '', $value ), 0, $this->parameter['length'] );
   }

}

?>
