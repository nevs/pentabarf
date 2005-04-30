<?php

require_once('../classes/database/datatypes/dt_base.php');


/// class for text values
class DT_TEXT extends DT_BASE 
{

   public function __construct( $parent, $name, $parameter = array(), $properties = array() )
   {
      parent::__construct( $parent, $name, $parameter, $properties ); 
   }

   /// set the value
   public function set( $value )
   {
      $this->value = str_replace( '\\', '', $value );
   }

}

?>
