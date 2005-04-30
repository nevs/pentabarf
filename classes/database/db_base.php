<?php

require_once('../classes/exception/db_critical.php');
require_once('../classes/exception/db_error.php');

define('NO_TRANSACTION', 0);
define('TRANSACTION', 1);

/// Base-Class for all database stuff
abstract class DB_BASE implements Iterator
{

  /// name of the database
  static private $database = '';
  /// username of the database
  static private $db_user = '';
  /// password of the database user
  static private $db_password = '';
  /// shared database connection
  static protected $db_connection = 0;
  /// secondary shared database connection for transactions
  static protected $db_transaction = 0;
  /// person_id of the authenticated user
  static protected $auth_person_id = 0;
  /// login-name of the authenticated user
  static protected $auth_login_name = '';
  /// language of the preferred language of the authenticated user
  static protected $auth_language_id = 0;
  /// permissions of the authenticated user
  static protected $permissions = array();


  /// name of the table addressed by this class (has to be set in derived classes)
  protected $table = '';
  /// name of the domain this table belongs to (used for permission handling)
  protected $domain = '';
  /// array with the database fields of this table (has to be set in derived classes)
  protected $fields = array();
  /// limit the number of records for queries (0 means no limit)
  protected $limit = 0;
  /// order for queries
  protected $order = '';


  /// resultset of the last database query
  protected $data = array();
  /// number of the current resultset
  protected $current_record = 0;
  /// is the current record a new one
  protected $current_new = true;
  /// debug mode on/off
  protected $debug = false;

  /// constructor for the class DB_Base
  protected function __construct()
  {
    require_once('../config/database.php');

    if ( !DB_Base::$db_connection )
    { // open the shared database connection
      DB_Base::$db_connection = pg_connect( "dbname='".DB_Base::$database."' user='".DB_Base::$db_user."' password='".DB_Base::$db_password."'" );
      if ( !DB_Base::$db_connection ) {
        throw new DB_Critical('Could not connect to database.');
      }
    }
  }
  
  /// clear resultset
  public function clear()
  {
    $this->current_record = 0;
    $this->current_new = true;
    $this->data = array();
  }

  /// create new record
  public function create()
  {
    $this->clear();
    foreach ( $this->fields as $key => $value ) 
    {
      $this->data[ 0 ][ $key ] = $value->clone();
    }
  }

  /// getter
  public function get( $name )
  {
    if ( isset( $this->data[ $this->current_record ][ $name ] ) )
    {
      return $this->data[ $this->current_record ][ $name ]->get();
    } else if (isset( $this->fields[ $name ] ) ) {
      trigger_error("Index out of bound.");
    } else {
      throw new DB_Critical('Unknown fieldname!');
    }
  }

  /// getter
  public function __get( $name )
  {
    return $this->get( $name );
  }

  /// setter
  public function set( $name, $value )
  {
    if ( isset( $this->fields[ $name ] ) )
    {
      $this->data[ $this->current_record ][ $name ]->set( $value );
    } else {
      throw new DB_Critical('Unknown fieldname!');
    }
  }

  /// setter
  public function __set( $name, $value )
  {
    return $this->set( $name, $value );
  }

  /// execute sql queries
  protected function query( $sql, $mode = NO_TRANSACTION )
  {
    if ( $this->debug && $this->check_authorization( 'show_debug' ) ) 
    {
      echo $sql;
    }
    if ( $mode == TRANSACTION && !DB_Base::$db_transaction )
    { // open the shared database connection for transactions if necessary
      DB_Base::$db_transaction = pg_connect( "dbname='".DB_Base::$database."' user='".DB_Base::$db_user."' password='".DB_Base::$db_password."'", PGSQL_CONNECT_FORCE_NEW );
      if ( !DB_Base::$db_transaction ) {
        throw new DB_Critical('Could not connect to database (secondary connection).');
      }
    }

    $connection = $mode == TRANSACTION ? DB_Base::$db_transaction : DB_Base::$db_connection;
    if ( ! ( $result = pg_query( $connection, $sql ) ) )
    {
      throw new DB_Error( "SQL: $sql\n".pg_last_error($connection));
    } else {
      if ( pg_last_notice( $connection ) ) 
      {
        throw new DB_Warning( pg_last_notice( $connection) );
      }
      return $result;
    }
  }

  /// select values from the database
  protected function &real_select( $sql )
  {
    $result = $this->query( $sql, NO_TRANSACTION );
    $this->clear();

    for ( $i = 0; $i < pg_num_rows( $result ); $i++ )
    {
      $current_record = pg_fetch_array( $result, $i, PGSQL_ASSOC );
      foreach ( $this->fields as $key => $value )
      {
        $this->data[ $i ][ $key ] = clone $value;
        $this->data[ $i ][ $key ]->import( $current_record[ $key ] );
      }
    }
    $this->current_new = count( $this->data ) ? false : true;
    pg_free_result( $result );
    return count( $this->data );
  }

  /// select single values from the database
  protected function &real_select_single( $sql )
  {
    $result = $this->query( $sql, NO_TRANSACTION );
    if ( pg_num_rows( $result ) === 1 )
    {
      return pg_fetch_result( $result, 0 );
    } else {
      return false;
    }
  }
  
  /// public interface for querying the database
  public function select( $condition = array() )
  {
    $cond = $this->compile_where( $condition );
    $fields = '';
    foreach ($this->fields as $key => $value )
    {
      if ( get_class($value) == 'DT_BYTEA' ) continue;
      $fields .= $fields != '' ? ', ' : '';
      $fields .= $key;
    }
    $sql = "SELECT $fields FROM {$this->table}{$cond}";
    if ($this->order != '') $sql .= " ORDER BY {$this->order}";
    if ($this->limit != 0) $sql .= " LIMIT {$this->limit}";
    
    return $this->real_select( $sql );
  }

  /// build where-clause from conditions
  protected function compile_where( $condition )
  {
    $cond = '';
    foreach ( $condition as $key => $value )
    { // loop through all conditions;
      if ( ! isset($this->fields[ $key ]) )
      {
        throw new DB_Error("Unknown condition {$key} => ".print_r( $value ));
      } else {
        if ( $value === true )
        { // query for not null values
          $cond .= $cond == '' ? ' WHERE ' : ' AND ';
          $cond .= "{$key} IS NOT NULL";
          continue;
        } else if ( $value === false ) {
          // query for null values
          $cond .= $cond == '' ? ' WHERE ' : ' AND ';
          $cond .= "{$key} IS NULL";
          continue;
        } else {
          // query for real values
          $values = array();
          if ( ! is_array( $value ) )
          {
            $value = array( $value );
          }
          foreach ( $value as $cur_value )
          { // put all legitimate values in an array
            $cur_value = $this->fields[ $key ]->escape( $cur_value ); 
            if ( $cur_value === false )
            {
              throw new DB_Error("Empty condition {$key}.");
            } else {
              $values[] = $cur_value;
            }
          }

          if ( count( $values ) == 0 )
          { // ignore empty values
            continue;
          } else {
            $cond .= $cond == '' ? ' WHERE ' : ' AND ';
            $cond .= $key;
            if ( count( $values ) == 1 )
            {
              $cond .= ' = '.implode( '', $values );
            } else {
              $cond .= ' IN ('.implode( ', ', $values ).')';
            }
          }
        }
      }
    }
    return $cond;
  }

  /// write current record back to database
  public function write( $mode = NO_TRANSACTION )
  {
    if ( $this->current_new && $this->check_permission( 'create' ) )
    {
      return $this->query( $this->insert(), $mode );
    } else if ( $this->check_permission( 'modify' ) ) {
      return $this->query( $this->update(), $mode );
    }
    return false;
  }

  /// build sql statement for inserts
  protected function insert()
  {
    $fields = array();
    $values = array();
    foreach ( $this->fields as $key => $v )
    {
      $value = $this->data[ $this->current_record ][ $key ]->escape();
      if ( $value === false && $v->check('NOT NULL') )
      {
        if ( $v->default() )
        {
          continue;
        } else {
          throw new DB_Error("Empty NOT NULL field: {$key}.");
        }
      } else {
        $fields[] = $key;
        $values[] = $value === false ? "NULL" : $value;
      }
    }
    return "INSERT INTO {$this->table} (".implode( ', ', $fields ).") VALUES (".implode( ', ', $values ).");";
  }

  /// build sql statements for updates
  protected function update()
  {
    $pkey = array();
    $values = array();
    foreach ( $this->fields as $key => $v )
    {
      $value = $this->data[ $this->current_record ][ $key ]->escape();
      if ( $value === false && $v->check('NOT NULL') )
      {
        throw new DB_Error("Empty NOT NULL field: {$key}.");
      } else {
        if ( $v->check('PRIMARY KEY') )
        {
          $pkey[] = "{$key} = {$value}";
        }
        $value = $value === false ? "NULL" : $value;
        $values[] = "{$key} = {$value}";
      }
    }
    if ( count( $pkey ) < 1 || count( $values ) < 1 )
    {
      throw new DB_Error('Something went wrong for update.');
    }
    return "UPDATE {$this->table} SET ".implode( ', ', $values )." WHERE ".implode( ' AND ', $pkey ).";";
  }

  /// delete current record
  public function delete( $mode = NO_TRANSACTION )
  {
    if ( $this->current_new )
    {
      throw new DB_Error('Deleting new records is stoopid.');
    }
    if ( ! $this->check_permission( 'delete' ) )
    {
      return;
    }
    $pkey = array();
    foreach ( $this->fields as $key => $v )
    {
      if ( $v->check('PRIMARY KEY') === false )
      {
        continue;
      }
      $value = $this->data[ $this-->current_record ][ $key ]->escape();
      if ( $value === false )
      {
        throw new DB_Error("Empty NOT NULL field: {$key}.");
      } else {
        $pkey[] = "{$key} = {$value}";
      }
    }
    if ( count( $pkey ) < 1)
    {
      throw new DB_Error('Something went wrong while deleting.');
    }
    $sql = "DELETE FROM {$this->table} WHERE ".implode( ' AND ', $pkey ).";";
    return $this->query( $sql, $mode );
  }

  /// start a transaction
  public function begin()
  {
    $this->query( 'BEGIN TRANSACTION;', TRANSACTION );
  }

  /// commt a transaction
  public function commit()
  {
    $this->query( 'COMMIT TRANSACTION;', TRANSACTION );
  }

  /// rollback transaction
  public function rollback()
  {
    $this->query( 'ROLLBACK TRANSACTION;', TRANSACTION );
  }

  /// retrieve permissions of the current user
  protected function get_permissions()
  {
    $sql = "SELECT get_permissions FROM get_permissions('".pg_escape_string( $this->get_auth_person_id() )."');";
    $result = $this->query( $sql, NO_TRANSACTION );
    DB_Base::$permissions = array();
    while ( $row = pg_fetch_array( $result) )
    {
      DB_Base::$permissions[] = $row['get_permissions'];
    }
  }

  /// check for an authorization
  public function check_authorization( $authorization )
  {
    return in_array( $authorization, DB_Base::$permissions );
  }

  /// check for a permission
  protected function check_permission( $action )
  {
    if ( !$this->domain )
    {
      throw new DB_Critical('$domain not defined for class '.get_class( $this ) );
    }
    if ( in_array( $action, array( 'modify', 'create', 'delete' ) ) )
    { // if we are in a link table you only need modify privileges to insert/delete
      if ( $this->domain != $this->table )
      {
        $action == 'modify';
      }
      $authorization = $action.'_'.$this->domain;
    } else {
      throw new DB_Critical('this should not be reached.');
    }
    try
    {
      if ( in_array( $authorization, DB_Base::$permissions ) )
      {
        throw new Exception("allowed: $authorization", 1);
      }
      throw new Exception("not allowed: $authorization", 0);
    }
    catch(Exception $e)
    {
      switch ( $e->getCode() )
      {
        case 0: // all disallowed actions 
          trigger_error( 'check_authorization: '.$e->getMessage() );
          return false;
          break;
        case 1: // all allowed actions
          return true;
          break;
        default:
          throw new DB_Critical( 'check_authorization: unknown Code '.$e->getMessage() );
          return false;
      }
    }
  }

  /// get the fieldnames of the table
  public function get_field_names()
  {
    $field_names = array();
    foreach ($this->fields as $key => $v )
    {
      $field_names[] = $key;
    }
    return $field_names;
  }

  /// get the number of records in the current resultset
  public function get_count()
  {
    return count( $this->data );
  }

  /// get the person_id of the authenticated person
  public function get_auth_person_id()
  {
    return DB_Base::$auth_person_id;
  }

  /// get the login_name of the authenticated person
  public function get_auth_login_name()
  {
    return DB_Base::$auth_login_name;
  }

  /// set the person_id of the authenticated person
  protected function set_auth_person_id( $person_id )
  {
    DB_Base::$auth_person_id = (integer) $person_id;
  }

  /// set the login_name of the authenticated person
  protected function set_auth_login_name( $login_name )
  {
    DB_Base::$auth_login_name = $login_name;
  }

  /// get the current limit for selects
  public function get_limit()
  {
    return $this->limit;
  }

  /// set the current limit for selects
  public function set_limit( $limit )
  {
    $this->limit = (integer) $limit;
  }

  /// get the current debug state
  public function get_debug()
  {
    return $this->debug;
  }

  /// set the current debug state
  public function set_debug( $debug )
  {
    $this->debug = $debug == true ? true : false;
  }

  /// get the language_id of the preferred language of the current user
  public function get_auth_language_id()
  {
    return DB_Base::$auth_language_id;
  }

  /// set the language_id for the preferred language of the current user
  public function set_auth_language_id( $language_id )
  {
    DB_Base::$auth_language_id = (integer) $language_id;
  }

  /// rewind to the first element
  public function rewind()
  {
    $this->current_record = 0;
  }

  /// return the current record of the database query
  public function current()
  {
    return $this->current_record;
  }

  /// returns the number of the currently active record
  public function key()
  {
    return $this->current_record;
  }

  /// switch to the next record of the query
  public function next()
  {
    $this->current_record++;
    if ( $this->current_record >= count( $this->data ) )
    {
      return false;
    } else {
      return true;
    }
  }

  /// switch to the previos record of the query
  public function prev()
  {
    $this->current_record--;
    if ($this->current_record < 0)
    {
      $this->current_record = 0;
      return false;
    } else {
      return true;
    }
  }

  /// returns true if we are working on a valid record
  public function valid()
  {
    if ( ! is_array( $this->data ) )
    {
      return false;
    } else if ( count( $this->data ) > 0 && $this->current_record < count( $this->data ) ) {
      return true;
    } else {
      return false;
    }
  }

}

?>
