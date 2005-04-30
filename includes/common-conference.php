<?php

  require_once("../db/conference_role_localized.php");
  require_once("../db/view_person.php");
  require_once("../db/link_type.php");


  // get list of conference roles
  $role = new Conference_Role_Localized;
  $role->select(array("language_id" => $preferences["language"]));
  add_js_vars("conference_roles", $role, "conference_role_id", "name");


  // get names of persons
  $person = new View_Person;
  $person->select();
  add_js_vars("person_names", $person, "person_id", "name");


  // get link types
  $link_type = new Link_Type;
  $link_type->select();
  add_js_vars("link_types", $link_type, "link_type_id", "tag");


?>
