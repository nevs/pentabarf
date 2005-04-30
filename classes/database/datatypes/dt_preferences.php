<?php

require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/exception/db_warning.php');


/// class for text values
class DT_PREFERENCES extends DT_TEXT
{

   /// constructor of this class
   public function __construct( $parent, $name, $parameter = array(), $properties = array() )
   {
      parent::__construct( $parent, $name, $parameter, $properties ); 
   }

   /// set the value
   public function set( $preferences )
   {
      if ( ! is_array( $preferences ) )
      {
         $preferences = array();
         throw new DB_Warning('preferences has to be an array');
      }
      $preferences = $this->check_array( $preferences );
      $pref_numbers = array( 'current_event', 'current_person', 'conference', 'language' );
      $pref_strings = array( 'find_events', 'find_events_type', 'find_persons', 'find_persons_type', 'find_conference', 'current_report' );
      $pref_arrays = array( 'find_events_advanced', 'find_persons_advanced' );
      
      foreach($pref_numbers as $value)
      {
         $preferences[ $value ] = isset( $preferences[ $value ] ) ? (integer) $preferences[ $value ] : 0;
      }

      foreach($pref_strings as $value)
      {
         $preferences[ $value ] = isset( $preferences[ $value ] ) ? $preferences[ $value ] : '';
      }
      
      foreach($pref_arrays as $value)
      {
         $preferences[ $value ] = isset( $preferences[ $value ] ) ? $preferences[ $value ] : array();
      }
      $this->value = $preferences;
   }

   /// unserialize preferences while importing
   public function import( $value )
   {
      return $this->set( unserialize( $value ) );
   }

   /// return the escaped value
   public function escape( $value = null )
   {
      if ( $value === null )
      {
         $value = $this->value;
      }
      return "'".pg_escape_string( serialize( $value ) )."'";
   }

   /// check all keys and values of an array recursively
   protected function &check_array( &$array )
   {
      $clean = array();
      foreach( $array as $key => $value ) {
         $clean_key = preg_replace( '/[\000-\037\200-\377]+/' , '', $key );
         if ( is_array( $value ) ) 
         {
            $clean[ $clean_key ] = $this->check_array( $value );
         } else {
            $clean[ $clean_key ] = preg_replace( '/[\000-\037\200-\377]+/', '', $value );
         }
      }
      return $clean;
   }

}

?>
