<?php

  require_once("../db/view_person.php");
  require_once("../db/person_travel.php");
  require_once("../db/person_rating.php");
  require_once("../db/person_watchlist_person.php");
  require_once("../db/person_language.php");
  require_once("../db/person_role.php");
  require_once("../db/country_localized.php");
  require_once("../db/transport_localized.php");
  require_once("../db/currency.php");
  require_once("../db/person_phone.php");
  require_once("../db/person_im.php");
  require_once("../db/conference.php");
  require_once("../db/view_event_person_event.php");
  require_once("../db/view_person_link.php");
  require_once("../db/person_keyword.php");
  require_once("../db/role.php");
  require_once("../db/role_localized.php");
  require_once("../db/person_transaction.php");
  require_once("../db/event_state_localized.php");
  require_once("../db/person_image.php");
  require_once("../functions/tabs.php");
  require_once("../functions/fill_select.php");
  require_once("../functions/rating_summary.php");
  require_once("../functions/template.php");
  require_once("../includes/common-person.php");

  
  $person = new View_Person;
  
  if (isset($_POST["select_person"]) && $person->select(array('person_id' => $_POST["select_person"]))) {
    header("Location: ".get_person_url($person));
    exit;
  } 

  if (!$person->select(array('person_id' => $RESOURCE ? $RESOURCE : $preferences['current_person']))) {
    header("Location: ".get_url("find_person"));
    exit;
  }

  // array with the names of the tabs
  $tab_names = array("events", "general", "contact", "links", "description", "rating", "travel", "account");
  content_tabs($tab_names, $template);
  
  $transaction = new Person_Transaction;
  if ( $transaction->select(array('person_id' => $person->get('person_id') ) ) ) {
    $template->addVar("content", "TIMESTAMP", $transaction->get( 'changed_when' ) );
  }

  if (!$RESOURCE) header("Location: ".get_url("person/".$preferences['current_person']));
  
  $template->readTemplatesFromFile("view_person.tmpl");
  $template->addVar("main","CONTENT_TITLE", $person->get('name')."[#".$person->get('person_id')."]");
  $template->addVar("main","VIEW_TITLE","View Person");
  $template->setAttribute("register_handler", "visibility", "visible");
  
  // watch or unwatch person
  $watchlist = new Person_Watchlist_Person;
  $template->addVar("watch-button", "PERSON_ID", $person->get('person_id'));
  $template->addVar("watch-button","WATCH_BUTTON", $watchlist->select(array('person_id' => $person->get_auth_person_id(),'watched_person_id' => $person->get('person_id'))) ? $GLOBAL_TEXT_WATCHED : $GLOBAL_TEXT_UNWATCHED);

  // load person travel information for current conference
  $person_travel = new Person_Travel;
  if ($person_travel->select(array('person_id' => $person->get('person_id'),'conference_id' => $preferences['conference'])) != 1) {
    $person_travel->create();
  }


  // load person rating information for the current user
  $person_rating = new Person_Rating;
  $person_rating->select(array('person_id' => $person->get('person_id'),'evaluator_id' => $person->get_auth_person_id()));

  
  // enable person navigation and fill it with data
  $person_selection = new View_Watchlist_Person;
  $person_selection->select(array('watcher_person_id' => $person->get_auth_person_id()));
  fill_selector("person_list", $person_selection, "person_id", "name", $person->get('person_id'), $person);
  $template->setAttribute("person_navigation","visibility","visible");

  
  // save current tab and current person 
  if ($person->get('person_id') && strtolower($VIEW) != "preferences") {
    $preferences['current_person'] = $person->get('person_id');
    $auth_person->set('preferences', $preferences);
    if ($auth_person->check_authorisation("modify_own_person")) {
      $auth_person->write();
    }
  }

  $user_prefs = $person->get('preferences');

  member_to_template($person, array('password', 'preferences'));

  if (isset($user_prefs["images"])) {
    if ($user_prefs["images"]["person"]) $template->addVar("content", "PREF_IMAGES_PERSON", "checked='checked'");
    if ($user_prefs["images"]["event"]) $template->addVar("content", "PREF_IMAGES_EVENT", "checked='checked'");
    if ($user_prefs["images"]["conference"]) $template->addVar("content", "PREF_IMAGES_CONFERENCE", "checked='checked'");
  }

  $template->addVar("content", "IMAGE_URL", get_person_image_url($person, "64x64", false));
  
  $person_image = new Person_Image;
  if ($person_image->select(array('person_id' => $person->get('person_id')))) {
    $template->addVar("content", "IMAGE_PUBLIC", $person_image->get('f_public') == 't' ? "checked='checked'" : "");
  }

  
  member_to_template($person_travel, array('person_id', 'conference_id', 'f_arrival_pickup', 'f_departure_pickup', 'f_arrived'));
  $template->addVar("content","F_ARRIVAL_PICKUP",$person_travel->get('f_arrival_pickup') == 't' ? "checked='checked'" : "");
  $template->addVar("content","F_DEPARTURE_PICKUP",$person_travel->get('f_departure_pickup') == 't' ? "checked='checked'" : "");
  $template->addVar("content","F_ARRIVED",$person_travel->get('f_arrived') == 't' ? "checked='checked'" : "");
  
  if ($person_rating->get_count()) {
    member_to_template($person_rating, array('person_id', 'evaluator_id', 'speaker_quality', 'competence', 'remark'));
    $template->addVar("content","SPEAKER_QUALITY_".($person_rating->get('speaker_quality') ? $person_rating->get('speaker_quality') : "0"),"checked='checked'" );
    $template->addVar("content","COMPETENCE_".($person_rating->get('competence') ? $person_rating->get('competence') : "0"),"checked='checked'" );
    $template->addVar("content","RATING_REMARK", $person_rating->get('remark'));
  }

  
  if ($person->get('gender')) {
    $template->addVar("content", $person->get('gender') == "t" ? "GENDER_M" : "GENDER_F", "selected='selected'");
  }
  
  $country = new Country_Localized;
  $country->select(array('language_id' => $preferences['language']));
  fill_select("country", $country, "country_id", "name", $person->get('country_id'));

  $transport = new Transport_Localized;
  $transport->select(array('language_id' => $preferences['language']));
  fill_select("arrival_transport", $transport, "transport_id", "name", $person_travel->get('arrival_transport_id'));
  fill_select("departure_transport", $transport, "transport_id", "name", $person_travel->get('departure_transport_id'));


  $currency = new Currency;
  $currency->select(array('f_visible' => 't'));
  fill_select("travel_currency", $currency, "currency_id", "iso_4217_code", $person_travel->get('travel_currency_id'),false);
  fill_select("accommodation_currency", $currency, "currency_id", "iso_4217_code", $person_travel->get('accommodation_currency_id'),false);
  fill_select("fee_currency", $currency, "currency_id", "iso_4217_code", $person_travel->get('fee_currency_id'),false);


  $role = new Role;
  $role_localized = new Role_Localized;
  $person_role = new Person_Role;
  $role->select();
  foreach($role as $key) {
    $role_localized->select(array('role_id' => $role->get('role_id'),'language_id' => $preferences['language']));
    $roles[$key] = array(
      'ROLE_LABEL'     => $role_localized->get_count() ? $role_localized->get('name') : $role->get('tag'),
      'ROLE_NAME'      => "role[".$role->get('role_id')."]",
      'ROLE_ACTIVE'    => $person_role->select(array('person_id' => $person->get('person_id'), 'role_id' => $role->get('role_id'))) == 1 ? "checked='checked'" : "");
  }
  $template->addRows('role',$roles);
  
  
  $person_rating->select(array('person_id' => $person->get('person_id')));
  rating_summary("QUALITY", $person_rating, "speaker_quality");
  rating_summary("COMPETENCE", $person_rating, "competence");
  
  $conference = new Conference;
  if ($conference->select()) {
    fill_select("conference", $conference, "conference_id", "title", $preferences['conference']);
  }

  
  $person_phone = new Person_Phone;
  if ($person_phone->select(array('person_id' => $person->get('person_id')))) {
    add_js_init_function("add_person_phone", $person_phone, array("person_phone_id", "phone_type_id", "phone_number"));
  }
  
  $person_language = new Person_Language;
  if ($person_language->select(array('person_id' => $person->get('person_id')))) {
    add_js_init_function("add_person_language", $person_language, "language_id");
  }

  
  // add im's of the person
  $person_im = new Person_IM;
  if ($person_im->select(array('person_id' => $person->get('person_id')))) {
    add_js_init_function("add_person_im", $person_im, array("person_im_id", "im_type_id", "im_address"));
  }
 
  
  // add existing events of the person
  $event_person = new View_Event_Person_Event;
  if ($event_person->select(array('conference_id' => $preferences["conference"], 'person_id' => $person->get('person_id')))) {
    add_js_init_function("add_person_event", $event_person, array("event_person_id", "event_id", "event_role_id", "event_role_state_id", "remark"));

    // get states for the listed events
    add_js_vars("event_states", $event_person, "event_id", "event_state_id");
    $event_state = new Event_State_Localized;
    $event_state->select(array('language_id' => $preferences['language']));
    add_js_vars("event_state_names", $event_state, "event_state_id", "name");
  }



  // get public person links
  $person_link = new View_Person_Link;
  if ($person_link->select(array('person_id' => $person->get('person_id'), 'f_public' => 't'))) {
    add_js_init_function("add_public_link", $person_link, array("person_link_id", "link_type_id", "url", "title", "description"));
  }

  // get internal person links
  if ($person_link->select(array('person_id' => $person->get('person_id'), 'f_public' => 'f'))) {
    add_js_init_function("add_internal_link", $person_link, array("person_link_id", "link_type_id", "url", "title", "description"));
  }
 

  // get data for user interface language selection 
  $language = new Language_Localized;
  if ($language->select(array('language_id' => $preferences['language'])))
  {
    fill_select("language_list", $language, "translated_id", "name", $user_prefs['language'], true);
  }
  

  // add existing keywords
  $person_keyword = new Person_Keyword;
  if ($person_keyword->select(array('person_id' => $person->get('person_id')))) {
    add_js_init_function("add_keyword", $person_keyword, "keyword_id");
  }

  // get list of person ratings
  $rating = new Person_Rating;
  if ($rating->select(array('person_id' => $person->get('person_id'), 'remark' => true))) {
    $ratings = array();
    $rater = new View_Person;
    foreach($rating as $key){
      $rater->select(array('person_id' => $rating->get('evaluator_id')));
      array_push($ratings, array(
          'URL'       => get_person_url($rater),
          'IMAGE_URL' => get_person_image_url($rater),
          'NAME'      => $rater->get('name'),
          'OPINION'   => $rating->get('remark')
        ));
    }
    $template->addRows("opinions", $ratings);
  }

?>
