<?php

require_once('../classes/database/datatypes/dt_base.php');

/// class for integer values
class DT_DECIMAL extends DT_BASE
{

   public function __construct( $parent, $name, $parameter = array(), $properties = array() )
   {
      parent::__construct( $parent, $name, $parameter, $properties ); 

      if ( $this->parameter['precision'] <= 0 )
      {
         throw new DB_Critical('precision must be positive.');
      }
      if ( $this->parameter['scale'] < 0 )
      {
         throw new DB_Critical('scale must be positive.');
      }
   }

   /// set the value
   public function set( $value )
   {
      $this->value = floatval($value);
   }

}

?>
