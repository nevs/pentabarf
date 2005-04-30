<?php

  require_once('../db/entity.php');

  class Procedure extends Entity
  {
  
    protected $parameter = array();
  
    protected $distinct = array();
  
    public function __construct($select = array())
    {
      if (!$this->get_language_id()) {
        throw new Exception('language_id has to be set.',1);
      }
      parent::__construct($select);
    }
  
    public function select($parameter = array(), $condition = array())
    {
      $func = '';
      foreach($this->parameter as $name => $val) {
        if (!isset($parameter[$name])) {
          return 0;
        } else {
          $func .= $func != '' ? ', ' : '';
          $func .= "'".pg_escape_string(str_replace('\\', '', $parameter[$name]))."'";
        }
      }
      $func = $this->table.'('.$func.')';
      $fields = '';
      foreach($this->field as $key => $value) {
        if ($value['type'] == 'BYTEA') continue;
        $fields = $fields != '' ? $fields.', ' : '';
        $fields .= $key;
      }
      $where = $this->compile_where($condition);
      $sql = "SELECT $fields FROM $func".($where !== false ? $where : "" ).( $this->order ? " ORDER BY {$this->order}" : "").";";
      $result = $this->query($sql, NO_TRANSACTION);
      $this->clear();
      $done = array();
      for ($i = 0; $i < pg_num_rows($result); $i++) {
        $data = pg_fetch_array($result, $i, PGSQL_ASSOC);
        if (count($this->distinct) == 2) {
          if (in_array($data[$this->distinct[1]].':'.$data[$this->distinct[0]], $done)) continue;
          array_push($done, $data[$this->distinct[0]].':'.$data[$this->distinct[1]]);
        }
        array_push($this->data, $this->convert_to_data($data));
      }
      $this->new_record = count($this->data) ? false : true;
      pg_free_result($result);
      return count($this->data);
    }
  
    final public function delete()
    {
      throw new Exception("Deleting is not allowed on Procedures",1);
    }
  
    final public function set()
    {
      throw new Exception("Setting is not allowed on Procedures",1);
    }
  
    final public function write()
    {
      throw new Exception("Writing is not allowed on Procedures",1);
    }
  
    final public function begin()
    {
      throw new Exception("Starting Transactions is not allowed on Procedures",1);
    }
  
    final public function commit()
    {
      throw new Exception("Committing Transactions is not allowed on Procedures",1);
    }
  
    final public function rollback()
    {
      throw new Exception("Rolling back Transactions is not allowed on Procedures",1);
    }
  
  }

?>
