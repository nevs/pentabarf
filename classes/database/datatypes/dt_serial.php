<?php

require_once('../classes/database/datatypes/dt_integer.php');

/// class for integer values
class DT_SERIAL extends DT_INTEGER
{

   public function __construct( $parent, $name, $parameter = array(), $properties = array() )
   {
      parent::__construct( $parent, $name, $parameter, $properties ); 
   }

}

?>
