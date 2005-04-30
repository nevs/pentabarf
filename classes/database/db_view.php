<?php

require_once('../classes/database/db_base.php');

abstract class DB_VIEW extends DB_BASE
{
   final public function set( $name, $value)
   {
      throw new DB_Critical("Writing to views is not allowed!");
   }

   final public function write( $mode = NO_TRANSACTION )
   {
      throw new DB_Critical("Writing to views is not allowed!");
   }

}

?>
