<?php

  require_once("../db/view_person.php");
  require_once('../db/event.php');
  require_once("../db/event_role_localized.php");
  require_once("../db/view_event_role_state.php");
  require_once("../db/link_type.php");
  require_once("../db/keyword_localized.php");
  require_once('../db/attachment_type.php');


  // get names of persons
  $person = new View_Person;
  $person->select();
  add_js_vars("person_names", $person, "person_id", "name");


  // get events (for related events)
  $event = new Event;
  $event->select(array('conference_id' => $preferences['conference']));
  add_js_vars('event_names', $event, 'event_id', 'title');

  // get event roles
  $event_role = new Event_Role_Localized;
  $event_role->select(array('language_id' => $preferences['language']));
  // get event role states
  $role_state = new View_Event_Role_State;
  $role_state->clear();
  add_js_vars("event_role_states", $role_state, "event_role_state_id", "name");
  foreach($event_role as $key) {
    if ($role_state->select(array('language_id' => $preferences['language'], 'event_role_id' => $event_role->get('event_role_id'))) != 0) {
      add_js_vars("event_role_states[".$event_role->get('event_role_id')."]", $role_state, "event_role_state_id", "name", true);
    }
  }
  add_js_vars("event_roles", $event_role, "event_role_id", "name");


  // get public link types
  $link_type = new Link_Type;
  $link_type->select(array('f_public' => 't'));
  add_js_vars("public_link_types", $link_type, "link_type_id", "tag");


  // get internal link types
  $link_type = new Link_Type;
  $link_type->select(array('f_public' => 'f'));
  add_js_vars("internal_link_types", $link_type, "link_type_id", "tag");

  // get attachment types
  $attachment_type = new Attachment_Type;
  $attachment_type->select();
  add_js_vars('attachment_types', $attachment_type, 'attachment_type_id', 'tag');

  // get list of keywords
  $keyword = new Keyword_Localized;
  $keyword->select(array('language_id' => $preferences['language']));
  add_js_vars("keywords", $keyword, "keyword_id", "name");


?>
