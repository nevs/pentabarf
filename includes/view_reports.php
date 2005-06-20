<?php

  $template->readTemplatesFromFile("view_reports.tmpl");
  
  $reports = array("events", "expenses", "zeitplan", "persons", "pickup");

  if ($RESOURCE == "") {
    if (isset($preferences['current_report']) && in_array($preferences['current_report'], $reports)) {
      $target = $preferences['current_report']; 
    } else {
      $target = $reports[0];
    }
    header("Location: ".get_url("reports/".$target));
    exit;
  }

  if (!in_array($RESOURCE, $reports)){
    
    trigger_error("404 Page not found.");
    require_once("../wwwroot/error.html");
    exit;
    
  } else {
    
    $preferences['current_report'] = $RESOURCE;
    $auth_person->set('preferences', $preferences);
    if ($auth_person->check_authorisation("modify_own_person")) {
      $auth_person->write();
    }
    page_tabs($reports, "reports", $RESOURCE);
    $template->readTemplatesFromFile("view_reports_$RESOURCE.tmpl");
    require_once("view_reports_$RESOURCE.php");

  }


?>
