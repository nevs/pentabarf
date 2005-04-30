<?php

  // array of js vars
  $js_vars = array();

  // array of js functions to be executed on page load
  $init = array();


  function add_js_vars($varname, $class, $id_field, $value_field, $is_array = false, $add_empty = false)
  {
    global $js_vars;
    
    array_push($js_vars, array("FUNCTION" => ($is_array ? "" : "var ")."$varname = new Array();"));
    if ($add_empty) array_push($js_vars, array("FUNCTION" => $varname."[0] = 'not specified';"));
    if (is_object($class)) {
      foreach($class as $key) {
        $value = $class->get($value_field);
        if (mb_strlen($value) > 48){
          $value = mb_substr($value, 0, 46)."..";
        }
        array_push($js_vars, array("FUNCTION" => $varname."[".$class->get($id_field)."] = '".addslashes($value)."';"));
      }
    } else {
      foreach($class as $key => $value) {
        array_push($js_vars, array("FUNCTION" => $varname."[\"".$key."\"] = '".addslashes($value)."';"));
      }
    }
  }

  function add_js_init_function($function_name, $class, $values)
  {
    global $init;
  
    foreach($class as $key) {
      $parameter = "";
      if (!is_array($values)) {
        $parameter = "'".addslashes($class->get($values))."'";
      } else {
        foreach($values as $value) {
          $parameter .= $parameter ? ", " : "";
          $parameter .=  "'".addslashes($class->get($value))."'"; 
        }
      }
      array_push($init, array('FUNCTION' => $function_name."(".$parameter.");")); 
    }
  }

  function add_js_to_template($template)
  {
    global $BASE_URL;
    global $VIEW;
    global $RESOURCE;
    global $js_vars;
    global $init;

    // add view_url to the javascript vars
    array_push($js_vars, array("FUNCTION" => "var p_base = '$BASE_URL"."pentabarf/';"));
    array_push($js_vars, array("FUNCTION" => "var page_url = '$BASE_URL"."pentabarf/$VIEW/$RESOURCE';"));
    
    $template->addRows("init", $init);
    $template->addRows("js_vars", $js_vars);
  
  }

?>
