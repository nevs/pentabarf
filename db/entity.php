<?php

require_once('Date.php');
  

define('NO_TRANSACTION', 0);
define('TRANSACTION', 1);


/** 
 * Base-Class for all database objects. All classes
 * accessing the database are derived from this class. All classes derived
 * from this class share a common database connection and know about the 
 * authenticated user.
*/
abstract class Entity implements Iterator
{
  /**
   * Database name.
  */
  static private $database = '';

  /**
   * Database user.
  */
  static private $db_user = '';

  /**
   * Database password.
  */
  static private $db_pass = '';

  /**
   * Shared database connection
  */
  static protected $db_conn = 0;
  /**
   * Shared database connection for transactions
  */
  static protected $db_trans = 0;
  /**
   * person_id of the authenticated person.
  */
  static protected $auth_person_id = 0;
  /**
   * login_name of the authenticated person.
  */
  static protected $auth_login_name = '';
  /**
   * language_id ot the preferred language of the user.
  */
  static protected $language_id = 0;
  /**
   * login_name of the authenticated person.
  */
  static protected $permissions = array('modify_public');
  /**
   * Stores the result of the last database-query.
  */
  protected $data;
  /**
   * Number of the current resultset.
  */
  protected $current = 0;

  /**
   * Name of the database table from this object. This variable has to
   * be set in derived classes.
  */
  protected $table = "";

  /**
   * Domain of the table. This is used for authorisation of write access to tables.
  */
  protected $domain = "";

  /**
   * Array with the names of the database fields. Has to be set in derived classes.
  */
  protected $field = array();

  /**
   * Default Order for a query in this table
  */
  protected $order = "";

  /**
   * Limit for a query in this table
  */
  protected $limit = 0; 

  /**
   * is the current record a new one or from the database.
  */
  protected $new_record = true;
  
  /**
   * Flag whether debugging is enabled
  */
  protected $debug = false;
  
  /**
   * Constructor of the class Entity.
  */
  protected function __construct($select = array())
  {
    require_once('../config/database.php');
    
    if (!Entity::$db_conn) {
      Entity::$db_conn = pg_connect("dbname='".Entity::$database."' user='".Entity::$db_user."' password='".Entity::$db_pass."'");
      if (!Entity::$db_conn) {
        throw new Exception('Couldn\'t connect to database. You may contact sven@jabber.berlin.ccc.de for further help.',1);
      }
    }
    $this->clear();
    if (count($select)) {
      $this->select($select);
    }
  }

  /**
   * Clears all member variables.
  */
  public function clear()
  {
    $this->current = 0;
    $this->data = array();
    $this->new_record = true;
  }

  /**
   * Initialize data for filling with new values.
  */
  public function create()
  {
    $this->clear();
    foreach($this->field as $key => $val) {
      $this->data[0][$key] = "";
    }
    $this->data[0] = $this->convert_to_data($this->data[0]);
  }
  
  /**
   * Get a variable from the resultset.
  */
  public function get($name)
  {
    if ($this->current >= count($this->data)) {
      throw new Exception("index out of bound",1);
    }
    if (isset($this->field[$name])) {
      if ($this->field[$name]['type'] == 'BYTEA') {
        // fetch bytea fields directly from the database
        $cond = "";
        foreach($this->field as $key => $v) {
          if (isset($this->field[$key]['primary_key'])) {
            if ($this->data[$this->current][$key]) {
              $cond .= $cond != "" ? " AND" : "WHERE";
              $cond .= " $key = {$this->data[$this->current][$key]}";
            } else {
              throw new Exception("primary key field is zero.",1);
            }
          }
        }
        return pg_unescape_bytea($this->select_single($name, "SELECT {$name} FROM ".(isset($this->field[$name]['table']) ? $this->field[$name]['table'] : $this->table)." $cond;"));
      } else {
        return $this->data[$this->current][$name];
      }
    } else {
      throw new Exception("Requested field: $name does not exist.",1);
    }
  }

  /**
   * Set a variable.
  */
  public function set($name, $value)
  {
    if ($this->current >= count($this->data)) {
      throw new Exception("index out of bound",1);
    }
    if (isset($this->field[$name]) && $this->field[$name]['type'] != 'SERIAL') {
      switch($this->get_type($name))
      {
        case 'PASSWORD':
          $salt = pack("v4",rand(0,65535),rand(0,65535),rand(0,65535),rand(0,65535));
          $this->data[$this->current][$name] = bin2hex($salt).bin2hex(mhash_keygen_s2k(MHASH_MD5, $value, $salt, 16));
          break;
        case 'DATE': case 'DATETIME': case 'TIMESTAMP': case 'TIME': case 'INTERVAL':
          $this->data[$this->current][$name] = $this->convert($name, $value);
          break;
        default:
          $this->data[$this->current][$name] = str_replace("\\", "", $value);
      }
    } else {
      throw new Exception("Requested field: $name does not exist.",1);
    }
  }
  
  /**
   * Returns the type of a field.
  */
  public function get_type($field_name)
  {
    if (!isset($this->field[$field_name])) {
      throw new Exception("Unknown field: $field_name.", 1);
    } else {
      return $this->field[$field_name]['type'];
    }
  }
  
  /**
   * Checks integer values for correctness.
  */
  protected function check_integer($integer)
  {
    return intval($integer);
  }

  /**
   * Checks smallint values for correctness.
  */
  protected function check_smallint($smallint)
  {
    return intval($smallint);
  }

  /**
   * Checks interval values for correctness.
  */
  protected function check_interval($interval)
  {
    $interval = $this->check_char($interval);
    return preg_match("/^[0-2]?[0-9]:[0-5][0-9](:[0-5][0-9])?(\+[0-2]?[0-9])?$/", $interval) ? $interval : "";
  }
  
  /**
   * Checks date values for correctness.
  */
  protected function check_date($date)
  {
    $date = $this->check_char($date);
    return preg_match("/^(\d{2,4}[-.][0-1]?[0-9][-.][1-3]?[0-9]|[0-3]?[0-9][-.][0-1]?[0-9][-.]\d{2,4})$/", $date) ? $date : "";
  }
  
  /**
   * Checks time values for correctness.
  */
  protected function check_time($time)
  {
    $time = $this->check_char($time);
    return preg_match("/^[0-2]?[0-9]:[0-5][0-9](:[0-5][0-9])?(\+[0-2]?[0-9])?$/", $time) ? $time : "";
  }
  
  /**
   * Checks time values for correctness.
  */
  protected function check_timestamp($time)
  {
    return $this->check_char($time);
  }
  
  /**
   * Checks decimal values for correctness.
  */
  protected function check_decimal($decimal)
  {
    return floatval($decimal);
  }

  /** 
   * Checks strings for correctness.
  */
  protected function &check_char(&$char, $length = 0)
  {
    $char = rtrim($char);
    $char = str_replace(array("\\"), array(""), $char);
    $char = pg_escape_string($char);

    if ($length) {
      $char = str_replace(array("\n","\r"), array("", ""), $char);
      return $length < 0 ? $char : substr($char, 0, $length);
    } else {
      return $char;
    }
  }

  /** 
   * Escape binary data.
  */
  protected function &check_bytea(&$data)
  {
    return pg_escape_bytea($data);
  }

  /** 
   * Checks array before serialization.
  */
  protected function &check_array(&$array)
  {
    foreach($array as $key => $value) {
      if (is_array($value)) {
        $array[$key] = $this->check_array($value);
      } else {
        $array[$key] = str_replace(array("\"","'","\\","|","\r","\n"), "", $value);
      }
    }
    return $array;
  }

  /** 
   * Checks array before serialization.
  */
  protected function &check_preferences(&$preferences)
  {
    $preferences = $this->check_array($preferences);
    $pref_numbers = array('current_event', 'current_person', 'conference', 'language');
    $pref_strings = array('find_events', 'find_events_type', 'find_persons', 'find_persons_type', 'find_conference', 'current_report');
    $pref_arrays = array('find_events_advanced', 'find_persons_advanced');
    
    foreach($pref_numbers as $value){
      $preferences[$value] = isset($preferences[$value]) ? $this->check_integer($preferences[$value]) : 0;
    }

    foreach($pref_strings as $value){
      $preferences[$value] = isset($preferences[$value]) ? $preferences[$value] : '';
    }
    
    foreach($pref_arrays as $value){
      $preferences[$value] = isset($preferences[$value]) ? $preferences[$value] : array();
    }

    return $preferences;
  }

  /**
   * Execute SQL-queries.
  */
  protected function query($sql,$mode = NO_TRANSACTION)
  {
    if ($this->debug) echo $sql;
    if ($mode == TRANSACTION && !Entity::$db_trans) {
      Entity::$db_trans = pg_connect("dbname='".Entity::$database."' user='".Entity::$db_user."' password='".Entity::$db_pass."'", PGSQL_CONNECT_FORCE_NEW);
      if (!Entity::$db_trans) {
        throw new Exception("couldn't open secondary database connection.",1);
      }
    }
    $db_handle = $mode == TRANSACTION ? Entity::$db_trans : Entity::$db_conn;
    if (!($result = pg_query($db_handle, $sql))) {
      throw new Exception("error while accessing database".($mode == TRANSACTION ? " (TRANSACTION)" : "").".\nSQL: $sql\n".pg_last_error($db_handle),1);
    } else {
      if (pg_last_notice($db_handle)) trigger_error(pg_last_notice($db_handle));
      return $result;
    }
  }

  /**
   * Execute Queries for single values.
  */
  protected function &select_single($field_name, $sql)
  {
    $result = $this->query($sql, NO_TRANSACTION);
    if (pg_num_rows($result)) {
      return pg_fetch_result($result, 0, $field_name); 
    } else {
      return false;
    }
  }
  
  /**
   * Public Interface for selecting data.
  */
  public function select($condition = array())
  {
    $cond = $this->compile_where($condition);
    if ($cond === false) {
      $this->clear();
      // trigger_error('compile_where returned false.');
      return 0;
    }
    $fields = "";
    foreach($this->field as $key => $value) {
      if ($value['type'] == 'BYTEA') continue;
      $fields = $fields != "" ? $fields.", " : "";
      $fields .= (isset($this->field[$key]['name']) ?  "{$this->field[$key]['name']} AS $key" : $key);
    }

    $sql = "SELECT $fields FROM {$this->table}$cond".( $this->order ? " ORDER BY {$this->order}" : "").($this->limit ? " LIMIT {$this->limit}" : "").";";
    return $this->real_select($sql);
  }
  
  /**
   * Execute SQL-selects and automagically fill membervariables with the result.
  */
  protected function real_select($sql) {

    $result = $this->query($sql, NO_TRANSACTION);
    $this->clear();
    
    for ($i=0; $i<pg_num_rows($result); $i++) {
      $this->data[$i] = $this->convert_to_data(pg_fetch_array($result, $i, PGSQL_ASSOC));
    }
    
    $this->new_record = count($this->data) ? false : true;
    pg_free_result($result);
    return count($this->data);
  }

  protected function compile_where($condition)
  {
    if (!is_array($condition) && $condition) throw new Exception('$condition has to be an array.',1);
    $cond = "";
    foreach($condition as $key => $value) {
      $values = array();
      if (!isset($this->field[$key])) {
        throw new Exception("unknown condition: $key => $value", 1);
        continue;
      } else {
        if ($value === true) {
          $cond = $cond != "" ? $cond." AND " : " WHERE ";
          $cond .= "$key IS NOT NULL";
          continue;
        } else if ($value === false) {
          $cond = $cond != "" ? $cond." AND " : " WHERE ";
          $cond .= "$key IS NULL";
          continue;
        } else {
          if (!is_array($value)) { 
            $value = array($value); 
          } 
          foreach($value as $wert) {
            $wert = $this->escape($key, $wert);
            if ($wert === false) { 
              continue; 
            } else { 
              array_push($values, $wert); 
            }
          }
        }
      }
      if (0 == count($values)) {
        return false;        
        continue;
      }
      $cond = $cond != "" ? $cond." AND " : " WHERE ";
      $cond .= isset($this->field[$key]['name']) ? $this->field[$key]['name'] : 
          (isset($this->field[$key]['table']) ? $this->field[$key]['table'].".".$key : $key);
      if (count($values) == 1) {
        $cond .= " = ".implode("", $values);
      } else {
        $cond .= " IN (".implode(", ", $values).")";
      }
    }
    return $cond;
  }

  
  /**
   * Write member variables into the database.
  */
  public function write($mode = NO_TRANSACTION)
  {
    if ($this->new_record)
    {
      if (!$this->check_permission("create")) {
        throw new Privilege_Exception("Not enough privileges");
      } else {
        return $this->query($this->insert(), $mode);
      }
    } else {
      if (!$this->check_permission("modify")) {
        throw new Privilege_Exception("Not enough privileges");
      } else {
        return $this->query($this->update(), $mode);
      }
    }
  }

  /**
   * Start a transaction.
  */
  public function begin()
  {
    $this->query($sql = "BEGIN;",TRANSACTION);
  }

  /**
   * Commit a transaction.
  */
  public function commit()
  {
    $this->query($sql = "COMMIT;",TRANSACTION);
  }

  /**
   * Roll a transaction back.
  */
  public function rollback()
  {
    $this->query($sql = "ROLLBACK;",TRANSACTION);
  }

  /**
   * Insert new record into database.
  */
  protected function insert()
  {
    $fields = "";
    $values = "";
    foreach($this->field as $key => $v) {
      // read files for bytea fields
      if ($this->field[$key]['type'] == 'BYTEA') {
        $value = $this->check_char($this->data[$this->current][$key]);
        if (!$value) continue;
        if (!(is_file($value) && is_readable($value))) {
          throw new Exception("File $value is no file or is not readable.",1);
        } else { // file is readable
          $file_handle = fopen($value, "r");
          $data = fread($file_handle, filesize($value));
          fclose($file_handle);
          $data = pg_escape_bytea($data);
          $fields .= $fields != "" ? ", $key" : $key;
          $values .= $values != "" ? ", '$data'" : $value;
          unset($data);
        }
        continue;
      }
      $value = $this->escape($key);
      if ($value === false) {
        if (!isset($this->field[$key]['not_null'])) {
          $value = "NULL";
        } else {
          if (isset($this->field[$key]['default'])) {
            continue;
          } else if ($this->field[$key]['type'] == "SERIAL") {
            // field has a sequence try to get next value
            $value = $this->select_single("nextval", "SELECT nextval('{$this->table}_{$key}_seq')");
            $this->data[$this->current][$key] = $value;
          } else {
            throw new Exception("Field $key in table {$this->table} has to be set.",1);
          }
        }
      }
      $fields .= $fields != "" ? ", $key" : $key;
      $values .= $values != "" ? ", $value" : $value;
    }
    return "INSERT INTO {$this->table}($fields) VALUES ($values);";
  }

  /**
   * Update existing record in database.
  */
  protected function update()
  {
    $cond = "";
    $values = "";
    foreach($this->field as $key => $v)
    {
      if (isset($this->field[$key]['name'])) continue;
      if ($this->field[$key]['type'] == 'BYTEA') {
        if (isset($this->data[$this->current][$key]) && $this->data[$this->current][$key]) {
          trigger_error("Updating BYTEA fields not supported.");
        }
        continue;
      }
      $value = $this->escape($key);
      if ($value !== false) {
        $values .= $values != "" ? ", $key = $value" : "$key = $value";
      } else {
        if (isset($this->field[$key]['not_null'])) {
          throw new Exception("Field $key in Table {$this->table} has to be set.",1);
        } else {
          $values .= $values != "" ? ", $key = NULL" : "$key = NULL";
        }
      }
      if (isset($this->field[$key]['primary_key'])) {
        $cond .= $cond != "" ? " AND" : "WHERE";
        $cond .= " $key = {$this->data[$this->current][$key]}";
      }
    }
    return "UPDATE {$this->table} SET $values $cond;";
  }

  protected function escape($field_name, $value = null)
  {
    if (!isset($this->field[$field_name])) {
      throw new Exception("Unknown field: $field_name.",1);
    }
    if (!isset($value)) {
      if (!isset($this->data[$this->current][$field_name])) { return false; }
      $value = $this->data[$this->current][$field_name];
    } else { 
      $this->data[$this->current][$field_name] = $value;
    }
    switch($this->field[$field_name]['type']) {
      case 'CHAR': case 'VARCHAR': case 'TEXT': case 'PASSWORD':
        $value = $this->check_char($value, isset($this->field[$field_name]['length']) ? $this->field[$field_name]['length'] : 0);
        return $value != "" ? "'".$value."'" : false;
      case 'INET':
        $value = $this->check_char($value, isset($this->field[$field_name]['length']) ? $this->field[$field_name]['length'] : 0);
        return $value != "" ? "'".$value."'" : false;
      case 'INTEGER': case 'SERIAL':
        $value = $this->check_integer($value);
        return $value != 0 ? "'".$value."'" : false;
      case 'SMALLINT':
        $value = $this->check_integer($value);
        if ($value > 32767 || $value < -32768) return false;
        return $value != 0 ? "'".$value."'" : false;
      case 'DECIMAL':
        $value = $this->check_decimal($value);
        return $value != 0 ? "'".$value."'" : false;
      case 'BOOL':
        return $value == "" ? false : ($value == "t" ? "TRUE" : "FALSE");
      case 'TIME':
        return is_object($value) ? "'".$value->format('%H:%M:%S')."'" : false;
      case 'TIMESTAMP':
        return is_object($value) ? "'".$value->format('%Y-%m-%d %H:%M:%S')."'" : false;
      case 'EXACTTIMESTAMP':
        return 'now()';
      case 'DATE':
        return is_object($value) ? "'".$value->format('%Y-%m-%d')."'" : false;
      case 'INTERVAL':
        return is_object($value) ? "'".$value->format('%H:%M:%S')."'" : false;
      case 'PREFERENCES':
        return count($value) ? "'".serialize($this->check_preferences($value))."'": false;
      default:
        throw new Exception("Unsupported datatype ({$this->field[$field_name]['type']}) for {$this->table}:$field_name",1);
    }
  }

  protected function &convert_to_data(&$result)
  {
    $data = array();
    foreach($result as $key => $value) {
      if ($this->field[$key]['type'] == 'BYTEA') continue;
      $data[$key] = $this->convert($key, $value);
    }
    return $data;
  }

  protected function convert($key, $value)
  {
    if (!isset($this->field[$key])) {
      throw new Exception("Unsupported field $key",1);
      continue;
    } else {
      switch ($this->field[$key]['type']) {
        case 'VARCHAR': case 'CHAR': case 'TEXT': case 'PASSWORD':
        case 'SERIAL': case 'INTEGER': case 'SMALLINT': case 'DECIMAL':
        case 'BOOL':
        case 'EXACTTIMESTAMP':
        case 'INET':
          return $value;
          break;
        case 'DATE':
          $wert = new Date();
          if ($value == "") {
            return "";
          } else {
            $wert->setYear(strtok($value,"-"));
            $wert->setMonth(strtok("-"));
            $wert->setDay(strtok(" "));
            $wert->setHour(0);
            $wert->setMinute(0);
            $wert->setSecond(0);
          }
          return $wert;
          break;
        case 'TIMESTAMP': case 'DATETIME':
          $wert = new Date();
          if ($value == "") {
            return "";
          } else {
            $wert->setYear(strtok($value,"-"));
            $wert->setMonth(strtok("-"));
            $wert->setDay(strtok(" "));
            $wert->setHour(strtok(":"));
            $wert->setMinute(strtok(":"));
            $wert->setSecond(strtok("."));
          }
          return $wert;
          break;
        case 'TIME':
          return $value != "" ? new Date_Span(strtok($value, ".+")) : false;
          break;
        case 'INTERVAL': case 'TIME':
          return $value != "" ? new Date_Span(strtok($value, ".")) : false;
          break;
        case 'PREFERENCES':
          return $value != "" ? unserialize($value) : array();
          break;
        default:
          throw new Exception("Unsupported datatype {$this->field[$key]['type']}");
      }
    }
  }

  /**
   * Delete current record in database.
  */
  public function delete($mode = NO_TRANSACTION)
  {
    if ($this->new_record) {
      throw new Exception("deleting new records makes no sense.",1);
    }
    if (!$this->check_permission("delete")) return;
    $cond = "";
    foreach($this->field as $key => $value) {
      if (isset($this->field[$key]['primary_key'])) {
        $cond = $cond ? "$cond AND " : " WHERE ";
        if ($this->escape($key) === false) {
          throw new Exception("Empty primary key field: $key.",1);
        }
        $cond .= "$key = ".$this->escape($key);
      }
    }
    if (!$cond) {
      throw new Exception("no primary key fields defined for this table.",1);
    }
    $sql = "DELETE FROM {$this->table} $cond;";
    return $this->query($sql, $mode);
  }

  /**
   * Retrieve the permissions of the current user from the database.
  */
  protected function get_permissions()
  {
    $sql = "SELECT DISTINCT authorisation.tag FROM authorisation, role_authorisation,person_role where authorisation.authorisation_id = role_authorisation.authorisation_id AND person_role.role_id = role_authorisation.role_id AND person_role.person_id = {$this->get_auth_person_id()};";
    $result = $this->query($sql);
    Entity::$permissions = array();
    while ($row = pg_fetch_array($result))
    {
      array_push(Entity::$permissions, $row["tag"]);
    }
  }

  public function check_authorisation($authorisation)
  {
    return in_array($authorisation, Entity::$permissions) ? true : false;
  }

  /**
   * Check whether the authenticated user has a specific permission
  */
  protected function check_permission($action)
  {
    try
    {
      if (!$this->domain) throw new Exception("\$domain not defined for class ".get_class($this), 22);

      if ($action == "modify" || $action == "create" || $action == "delete")
      { // special handling for update, insert and delete
        if ($this->domain != $this->table) {
          $action = "modify";
        } else if ($action == "delete") {
          throw new Exception("delete not permitted for table ".$this->table.".", 0);
        }
        $action .= "_".$this->domain;
      }

      if (in_array($action, Entity::$permissions))
      {
        throw new Exception("allowed: $action", 1);
      } else {
        if ($action == "modify_person" && in_array("modify_own_person", Entity::$permissions)) 
        { 
          // check whether the user trys to update his own stuff

          if ($this->get('person_id') == $this->get_auth_person_id()) {
            throw new Exception("allowed: $action", 1);
          } else {
            throw new Exception("not allowed: $action", 0);
          }

        } else if ($action == "modify_event" && in_array("modify_own_event", Entity::$permissions)) {
          
          // check whether the user is involved in this event
          
          if (pg_num_rows($this->query("SELECT event_id FROM event_person WHERE person_id = ".$this->get_auth_person_id()." AND event_id = ".$this->get('event_id').";"))) {
            throw new Exception("allowed: $action", 1);
          } else {
            throw new Exception("not allowed: $action", 0);
          }

        }
        
        throw new Exception("not allowed: $action", 0);

      }

      throw new Exception("end of function reached in check_permission", 0);

    } catch(Exception $e) {
      switch ($e->getCode()) {
        case 0: // all disallowed actions end here
          trigger_error("Entity::check_permission(): ".$e->getMessage());
          return false;
          break;
        case 1: // all allowed actions end here
          return true;
          break;
        default: 
          throw new Exception("Entity::check_permission(): ".$e->getMessage(),1);
          return false;
      }
    }
    return false;
  }
  
  /**
   * Get the fieldnames of the table.
  */
  public function get_field_names()
  {
    $field_names = array();
    foreach($this->field as $key => $v) {
      if ($v['type'] == 'BYTEA') continue;
      array_push($field_names, $key);
    }
    return $field_names;
  }

  /**
   * Get the number of records in this table.
  */
  public function get_number_of_records() {
    return $this->select_single("count", "SELECT count(".$this->field_names[0].") FROM ".$this->table.";");
  }

  /**
   * Get the number of records in this object.
  */
  public function get_count() { return count($this->data); }

  /**
   * Get the order of this class.
  */
  public function get_order() { return $this->order; }

  /**
   * Get the person_id of the authenticated person.
  */
  public function get_auth_person_id() { return Entity::$auth_person_id; }

  /** 
   * Get the login_name of the authenticated person.
  */
  public function get_auth_login_name() { return Entity::$auth_login_name; }

  /**
   * Set the person_id of the authenticated person.
  */
  protected function set_auth_person_id($person_id) { Entity::$auth_person_id = $this->check_integer($person_id); }

  /**
   * Set the login_name of the authenticated person.
  */
  protected function set_auth_login_name($login_name) { Entity::$auth_login_name = $this->check_char($login_name); }
  
  /**
   * Set the order for this class
  */
  public function set_order($order) { $this->order = preg_match("/[a-z_, ]*/", $order) ? $order : $this->order; }

  /**
   * Get the Limit for this class
  */
  public function get_limit() { return $this->limit; }

  /**
   * Set the limit for this class
  */
  public function set_limit($limit) { $this->limit = $this->check_integer($limit); }

  /**
   * Get the current debug state.
  */
  public function get_debug() { return $this->debug; }

  /**
   * Set/Unset debug mode.
  */
  public function set_debug($mode) { $this->debug = $mode ? true : false; }

  /**
   * Get the currently active language-setting.
  */
  public function get_language_id() { return Entity::$language_id; }

  /**
   * Set the language_id for all language-dependant actions
  */
  public function set_language_id($language_id) { Entity::$language_id = $this->check_integer($language_id); }

  /**
   * Rewinds to the first element of multiple results from a database query.
   * (Needed for foreach statement overloading.)
  */
  public function rewind()
  {
    $this->current = 0;
  }

  /**
   * Returns the current record of the database query. (Needed for foreach statement overloading.)
  */
  public function current()
  {
    return $this->current;
  }

  /**
   * Returns the number of the current database record. (Needed for foreach statement overloading.)
  */
  public function key()
  {
    return $this->current;
  }

  /**
   * Returns the next record from the database query. (Needed for foreach statement overloading.)
  */
  public function next()
  {
    $this->current++;
    if ($this->current >= count($this->data)) return false;
  }

  /**
   * Returns the next record from the database query. (Needed for foreach statement overloading.)
  */
  public function prev()
  {
    $this->current--;
    if ($this->current <= 0)
    {
      $this->current = 0;
      return false;
    }
  }
  
  public function get_next($field_name)
  {
    if (count($this->data) > $this->current + 1)
    {
      return $this->data[$this->current + 1][$field_name];
    } else {
      return false;
    }
  }

  public function get_prev($field_name)
  {
    if ($this->current >= 1)
    {
      return $this->data[$this->current - 1][$field_name];
    } else {
      return false;
    }
  }

  /**
   * Returns true if the currently selected database record is valid. (Needed for foreach statement overloading.)
  */
  public function valid()
  {
    if (!is_array($this->data)) {
      return false;
    }
    return (count($this->data) > 0 && $this->current < count($this->data)) ? true : false;
  }

};

?>
