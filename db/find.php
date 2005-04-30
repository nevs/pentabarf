<?php

  require_once("../db/view.php");

  abstract class Find extends View
  {
    public function __construct($condition)
    {
      parent::__construct($condition);
    }
  
    protected function compile_where($search)
    {
      if ($search && !is_array($search)) throw new Exception('$search has to be an array.',1);
      $condition = array();
      foreach($search as $value) {
        // collapse search array
        if (!isset($this->search[$value['type']])) 
          throw new Exception("Unknown condition: {$value['type']} : {$value['value']}");
        if(isset($condition[$value['type']][$value['logic']])) {
          array_push($condition[$value['type']][$value['logic']], $value['value']);
        } else {
          $condition[$value['type']][$value['logic']] = array($value['value']);
        }
      }
      $cond = "";
      foreach($condition as $type => $types) {
        switch($this->search[$type]['type']) {
          case 'SIMPLE':
            switch($this->search[$type]['data']) {
              case 'TEXT':
                foreach($types['contains'] as $value) {
                  $text = "'%".$this->check_char($value)."%'";
                  $cond = $cond != "" ? $cond." AND " : " WHERE ";
                  $query = str_replace('{OP}', 'ILIKE', $this->search[$type]['query']);
                  $cond .= str_replace('{STRING}', $text, $query);
                }
                break;
              case 'INTEGER':
                $temp_cond = "";
                if (isset($types['is'])) {
                  foreach($types['is'] as $value) {
                    $text = "'".$this->check_integer($value)."'";
                    $temp_cond = $temp_cond != "" ? $temp_cond." OR " : "";
                    $query = str_replace('{OP}', '=', $this->search[$type]['query']);
                    $temp_cond .= str_replace('{STRING}', $text, $query);
                  }
                }
                if (isset($types['is not'])) {
                  foreach($types['is not'] as $value) {
                    $text = "'".$this->check_integer($value)."'";
                    $temp_cond = $temp_cond != "" ? $temp_cond." OR " : "";
                    $query = str_replace('{OP}', '<>', $this->search[$type]['query']);
                    $temp_cond .= str_replace('{STRING}', $text, $query);
                  }
                }
                if ($temp_cond != "") {
                  $cond = $cond != "" ? $cond." AND " : " WHERE ";
                  $cond = $temp_cond != "" ? $cond." (".$temp_cond.")" : $cond;
                }
                break;
              case 'INTERVAL':
                $temp_cond = "";
                foreach($types['is'] as $value) {
                  $text = "'".$this->check_interval($value)."'";
                  $temp_cond = $temp_cond != "" ? $temp_cond." OR " : "";
                  $query = str_replace('{OP}', '=', $this->search[$type]['query']);
                  $temp_cond .= str_replace('{STRING}', $text, $query);
                }
                if ($temp_cond != "") {
                  $cond = $cond != "" ? $cond." AND " : " WHERE ";
                  $cond = $temp_cond != "" ? $cond."(".$temp_cond.")" : $cond;
                }
                break;
              default:
                throw new Exception("Unsupported Datatyp ({$this->search[$type]['data']}).",1);
                break;
            }
            break;
          case 'SUBSELECT':
            $values = array();
            switch ($this->search[$type]['data']) {
              case 'INTEGER':
                if (isset($types['is'])) {
                  foreach($types['is'] as $value) {
                    if ($this->check_char($value) == "") continue;
                    array_push($values, "'".$this->check_integer($value)."'");
                  }
                  $temp_cond = $cond != "" ? " AND " : " WHERE ";
                  $query = str_replace('{OP}', 'IN', $this->search[$type]['query']);
                  $temp_cond .= str_replace('{STRING}', implode(', ', $values), $query);
                  $cond .= $temp_cond;
                }
                if (isset($types['is not'])) {
                  foreach($types['is not'] as $value) {
                    if ($this->check_char($value) == "") continue;
                    array_push($values, "'".$this->check_integer($value)."'");
                  }
                  $temp_cond = $cond != "" ? " AND " : " WHERE ";
                  $query = str_replace('{OP}', 'NOT IN', $this->search[$type]['query']);
                  $temp_cond .= str_replace('{STRING}', implode(', ', $values), $query);
                  $cond .= $temp_cond;
                }
                break;
              default:
                throw new Exception("Unsupported datatype ({$this->search[$type]['data']}).", 1);
                break;
            }
            break;

          default:
            throw new Exception("Unsupported searchtype {$this->search[$type]['type']}");
            break;
        }
      }
      return $cond;
    }
  }

?>
