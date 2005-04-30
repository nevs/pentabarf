<?php

require_once('../classes/database/datatypes/dt_base.php');

/// class for integer values
class DT_BOOL extends DT_BASE
{

   public function __construct( $parent, $name, $parameter = array(), $properties = array() )
   {
      parent::__construct( $parent, $name, $parameter, $properties ); 
   }

   /// set the value
   public function set( $value )
   {
      switch ($value)
      {
         case 't':
         case true:
            $this->value = 't';
            break;
         case 'f':
         case false:
            $this->value = 'f';
            break;
         default:
            $this->value = '';
      }
   }

}

?>
