<?php

  require_once('get_url.php');

function content_tabs($tab_names, $template, $tab = "")
{

  global $init;
  global $js_vars;

  if ($tab != "" && !in_array($tab, $tab_names)) $tab = "";
    
  // define tabs
  for ($i = 0; $i < count($tab_names);$i++) {
    $tabs[$i] = array('URL'   => "JavaScript:switch_tab('{$tab_names[$i]}');",
                      'ID'    => "tab-".$tab_names[$i],
                      'TEXT'  => $tab_names[$i],
                      'KEY'   => $i+1);
  }
  array_push($tabs, array('URL'   => "JavaScript:switch_tab('all');",
                          'ID'    => "tab-all",
                          'TEXT'  => "Show All Tabs",
                          'KEY'   => '0'));
  $template->addRows("tabs",$tabs);

  array_push($js_vars, array("FUNCTION" => "var tab_name = new Array();"));
  foreach($tab_names as $key => $value) {
    array_push($js_vars, array("FUNCTION" => "tab_name[$key] = '$value';"));
  }
 
  array_push($init, array("FUNCTION" => "switch_tab('$tab');"));
}

function page_tabs($tab_names, $page, $current)
{
  global $template;
  $current = $current != "" ? $current : $tab_names[0]; 
  // define tabs
  for ($i = 0; $i < count($tab_names);$i++) {
    $tabs[$i] = array('URL'   => get_url(($page != "" ? $page."/" : "").$tab_names[$i]),
                      'CLASS' => $tab_names[$i] == $current ? "tab active" : "tab inactive",
                      'TEXT'  => $tab_names[$i],
                      'KEY'   => $i+1);
  }
  $template->addRows("tabs",$tabs);

}

?>
