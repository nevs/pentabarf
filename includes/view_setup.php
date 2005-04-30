<?php
  
  exit;

  $tabs[0] = array('URL' => get_url(0,"setup/Localization"), 'TEXT' => "Localization");

  $template->addRows("tabs",$tabs);
  $template->readTemplatesFromFile("admin_valuelists.tmpl");
  $template->addVar("main","CONTENT_TITLE", "Setup");
  $template->addVar("main","VIEW_TITLE", "Setup");

  $language = new Language;
  $language_localized = new Language_Localized;

  $RESOURCE = "valuelists";
  
  $entry = array("Audience", "Authorisation", "Conference_Role", "IM_Type", "Event_Role", "Event_Role_State", "Event_State", "Event_Type", "Link_Type", "Keyword", "Phone_Type", "Role", "Time_Zone", "Transport", "UI_Message");

  $OPTIONS[0] = isset($OPTIONS[0]) && in_array($OPTIONS[0], $entry) ? $OPTIONS[0] : $entry[0];
  $current = strtolower($OPTIONS[0]);

  require_once("../db/".$current.".php");
  require_once("../db/".$current."_localized.php");
  eval('$class = new '.$OPTIONS[0].';');
  eval('$class_localized = new '.$OPTIONS[0]."_Localized;");
  $function = $current."_id";
  

  if(!isset($OPTIONS[1])) $OPTIONS[1] = $preferences['language'];

  // build menu
  foreach($entry as $key=> $value) 
  {
    $menu[$key]['VALUE'] = get_url(0,"setup/valuelists/".$value."/".$OPTIONS[1]);
    $menu[$key]['TEXT'] = $value;
    $menu[$key]['SELECTED'] = $OPTIONS[0] == $value ? "selected='selected'" : "";
  }
  $template->addRows("links",$menu);

 $language_localized->select_localized($preferences['language'],"name");
  foreach($language_localized as $key => $val) 
  {
    $menu_language[$key -1] = array (
        'VALUE'     => get_url(0,"setup/valuelists/".$OPTIONS[0]."/".$language_localized->get_translated_id()),
        'TEXT'      => $language_localized->get_name(),
        'SELECTED'  => $OPTIONS[1] == $language_localized->get_translated_id() ? "selected='selected'" : ""
      );
  }
  $template->addRows("language",$menu_language);

  // save new tag
  if (isset($_POST['action'])) 
  {
    $class->begin();
    if($_POST['action'] == "add_tag") 
    {
      $class->set_tag($_POST['new_tag']);
      $class->write(TRANSACTION);
    } 
      elseif ($_POST['action'] == "save_vals") 
    {
      foreach($_POST[$function."_id"] as $id) 
      {
        if($_POST[$function."_tag"][$id] != "")
        {
          if($class_localized->select_by_pkey($id,$OPTIONS[1]) AND $_POST[$function."_name"][$id] != "")
          {
            call_user_func(array($class_localized,"set_".$function),$_POST[$function."_id"][$id]);
            $class_localized->set_name($_POST[$function."_name"][$id]);
            $class_localized->write(TRANSACTION);
          } 
            elseif($class_localized->select_by_pkey($id,$OPTIONS[1]) AND $_POST[$function."_name"][$id] == "") 
          {
            $class_localized->delete(TRANSACTION);
          } 
            elseif(!$class_localized->select_by_pkey($id,$OPTIONS[1]) AND $_POST[$function."_name"][$id] != "") 
          {
            call_user_func(array($class_localized,"set_".$function),$_POST[$function."_id"][$id]);
            $class_localized->set_language_id($OPTIONS[1]);
            $class_localized->set_name($_POST[$function."_name"][$id]);
            $class_localized->write(TRANSACTION);
          }
        } 
          else 
        {
          if(call_user_func(array($class_localized,"select_by_".$function),$_POST[$function."_id"][$id]))
          $class_localized->delete(TRANSACTION);
          call_user_func(array($class,"select_by_".$function),$_POST[$function."_id"][$id]);
          $class->delete(TRANSACTION);
        }
        if(call_user_func(array($class,"select_by_".$function),$_POST[$function."_id"][$id]))
        {
          $class->set_tag($_POST[$function."_tag"][$id]);
          $class->write(TRANSACTION);
        }
      }
    }
    $class->commit();
    header("Location: ".get_url(0,"setup/valuelists/".$OPTIONS[0]."/".$OPTIONS[1]));
    exit;
  }
  $class->select_all($function);
  foreach($class as $number) 
  {
    $row[$number - 1]['ID'] = call_user_func(array($class,"get_".$function));
    $row[$number - 1]['ID_FIELD_NAME'] = $function."_id[".$row[$number - 1]['ID']."]";
    $row[$number - 1]['TAG'] = $class->get_tag();
    $row[$number - 1]['TAG_FIELD_NAME'] = $function."_tag[".$row[$number - 1]['ID']."]";
    $class_localized->select_by_pkey($row[$number - 1]['ID'],$OPTIONS[1]);      
    $row[$number - 1]['NAME'] = $class_localized->get_name();
    $row[$number - 1]['NAME_FIELD_NAME'] = $function."_name[".$row[$number - 1]['ID']."]";
    $row[$number - 1]['URL'] = get_url("setup/".$RESOURCE."/".$OPTIONS[0]."/".$OPTIONS[1]."/".$row[$number - 1]['ID']);
  }
  if (isset($row)) 
  {
    $template->addRows("rows",$row);
  }
  if ($OPTIONS[1]) 
  {
    call_user_func(array($class,"select_by_".$function),$OPTIONS[1]);
    $template->addVar("content","CURRENT_ID",call_user_func(array($class,"get_".$function)));
    $template->addVar("content","CURRENT_TAG",$class->get_tag());
  } 
    else 
  { 
    $template->addVar("content","CURRENT_ID","");
  }

?>
