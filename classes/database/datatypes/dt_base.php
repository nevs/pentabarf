<?php
   
/// base class for all datatypes
abstract class DT_BASE
{
   /// parent of this class
   protected $parent = 0;
   /// name of the field
   protected $name = '';
   /// parameter of the database field (length, precision, ...)
   protected $parameter = array();
   /// properties of the database field (not null, primary key, ...)
   protected $properties = array();
   /// value of this field
   protected $value = '';
   /// flag whether this field has been modified
   protected $dirty = false;

   /// constructor
   public function __construct(&$parent, $name, $parameter, $properties)
   {
      $this->parent = $parent;
      $this->name = $name;
      $this->parameter = $parameter;
      $this->properties = $properties;
   }

   /// get a new instance of this class with identical properties
   public function __clone()
   {
      $name = get_class( $this );
      return new $name( $this->parent, $this->name, $this->parameter, $this->properties );
   }

   /// get the value
   public function get()
   {
      return $this->value;
   }

   /// set the value
   public abstract function set( $value );

   /// do conversions and set the value (used when filling fields from the database) 
   public function import( $value ) 
   {
      $this->set( $value );
   }
   
   /// check this field for properties
   public function check( $property )
   {
      return in_array( strtoupper( $property ), $this->properties );
   }

   /// return the escaped value
   public function escape( $value = null )
   {
      if ( $value === null )
      {
         $value = $this->value;
      }
      return "'".pg_escape_string( $value )."'";
   }
 
}

?>
