<?php

require_once('entity.php');

abstract class View extends Entity
{
  protected $join = '';

  protected $distinct = '';

  public function __construct($select = array())
  {
    if (!$this->get_language_id()) {
      throw new Exception('language_id has to be set.',1);
    }
    parent::__construct($select);
  }

  public function select($condition = array())
  {
    $cond = $this->compile_where($condition);
    if ($cond === false) {
      $this->clear();
      // trigger_error("compile_where returned false. Table: {$this->table}\n Condition: ".print_r($condition, true));
      // throw new Exception('compile_where returned false.');
      return 0;
    }
    if ($this->join) {
      $cond .= $cond == "" ? " WHERE {$this->join}" : " AND {$this->join}";
    }
    $fields = '';
    foreach($this->field as $key => $value) {
      if ($value['type'] == 'BYTEA') continue;
      $fields = $fields != '' ? $fields.', ' : '';
      $fields .= (isset($this->field[$key]['name']) ? 
                 "{$this->field[$key]['name']} AS $key" : 
                 "{$this->field[$key]['table']}.".$key);
    }
    $sql = "SELECT $fields FROM {$this->table}$cond".( $this->order ? " ORDER BY {$this->order}" : "").";";
    $result = $this->query($sql, NO_TRANSACTION);
    $this->clear();
    if ($this->distinct != "") {
      if (in_array($this->distinct, $this->get_field_names())) {
        $done = array();
      } else {
        throw new Exception("Invalid distinct value",1);
        $this->distinct = "";
      }
    }
    for ($i = 0; $i < pg_num_rows($result); $i++) {
      $data = pg_fetch_array($result, $i, PGSQL_ASSOC);
      if ($this->distinct != "") {
        if (in_array($data[$this->distinct], $done)) continue;
        array_push($done, $data[$this->distinct]);
      }
      array_push($this->data, $this->convert_to_data($data));
    }
    $this->new_record = count($this->data) ? false : true;
    pg_free_result($result);
    return count($this->data);
  }

  final public function delete()
  {
    throw new Exception("Deleting is not allowed on Views",1);
  }

  final public function set()
  {
    throw new Exception("Setting is not allowed on Views",1);
  }

  final public function write()
  {
    throw new Exception("Writing is not allowed on Views",1);
  }

  final public function begin()
  {
    throw new Exception("Starting Transactions is not allowed on Views",1);
  }

  final public function commit()
  {
    throw new Exception("Committing Transactions is not allowed on Views",1);
  }

  final public function rollback()
  {
    throw new Exception("Rolling back Transactions is not allowed on Views",1);
  }

}

?>
