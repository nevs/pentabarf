<?php

  require_once("../db/union_recent_changes.php");

  $sub_pages = array('1 day', '3 days', '7 days');
  page_tabs($sub_pages, "recent_changes", $RESOURCE);
  
  $template->readTemplatesFromFile("view_recent_changes.tmpl");
  $template->addVar("main","CONTENT_TITLE", "Recent Changes");
  $template->addVar("main","VIEW_TITLE", "Recent Changes");

  $last_changes = array();
  $recent_changes = new Union_Recent_Changes;
  $recent_changes->select($RESOURCE);

  foreach($recent_changes as $key){
    array_push($last_changes, array(
        'URL'           => call_user_func('get_'.$recent_changes->get('type').'_url', $recent_changes->get('id')),
        'IMAGE_URL'     => call_user_func('get_'.$recent_changes->get('type').'_image_url', $recent_changes->get('id')),
        'TEXT'          => $recent_changes->get('title'), 
        'CHANGER_URL'   => get_person_url($recent_changes->get('changed_by')),
        'CHANGED_BY'    => $recent_changes->get('name'),
        'CHANGED_WHEN'  => $recent_changes->get('changed_when')->format('%Y-%m-%d %H:%M:%S')));
  }

  $template->addRows("last_changes", $last_changes);
  
?>
