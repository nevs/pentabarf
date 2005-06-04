<?php

  require_once('../db/person.php');
  require_once('../db/country_localized.php');
  require_once('../db/transport_localized.php');
  require_once('../db/currency.php');
  require_once('../db/role_localized.php');
  require_once('../db/conference.php');
  require_once('../functions/tabs.php');
  require_once('../functions/fill_select.php');
  require_once('../functions/rating_summary.php');
  require_once('../includes/common-person.php');

  $person = new Person;

  if ( $person->check_authorisation( 'create_person' ) !== true ) {
    throw new Privilege_Exception("Not allowed to create new persons.");
  }
  
  $template->readTemplatesFromFile('view_person.tmpl');
  $template->addVar('main','CONTENT_TITLE','New Person');
  $template->addVar('main','VIEW_TITLE','New Person');
  $template->setAttribute('register_handler', 'visibility', 'visible');
    

  // array with the names of the tabs
  $tab_names = array('general', 'contact', 'links', 'description', 'travel', 'account');
  content_tabs($tab_names, $template);
  

  $template->addVar('content', 'IMAGE_URL', get_person_image_url(0, '64x64'));

  // showing images in lists is activated for new user
  $template->addVar("content", "PREF_IMAGES_PERSON", "checked='checked'");
  $template->addVar("content", "PREF_IMAGES_EVENT", "checked='checked'");
  $template->addVar("content", "PREF_IMAGES_CONFERENCE", "checked='checked'");

  $country = new Country_Localized;
  $country->select(array('language_id' => $preferences['language']));
  fill_select('country', $country, 'country_id', 'name', 0);

  
  $transport = new Transport_Localized;
  $transport->select(array('language_id' => $preferences['language']));
  fill_select('arrival_transport', $transport, 'transport_id', 'name', 0);
  fill_select('departure_transport', $transport, 'transport_id', 'name', 0);

  
  $currency = new Currency;
  $def_curr = new Currency;
  $def_curr->select(array('f_default' => 't'));
  $currency->select(array('f_visible' => 't'));
  fill_select('travel_currency', $currency, 'currency_id', 'iso_4217_code', $def_curr->get('currency_id'), false);
  fill_select('accommodation_currency', $currency, 'currency_id', 'iso_4217_code', $def_curr->get('currency_id'), false);
  fill_select("fee_currency", $currency, "currency_id", "iso_4217_code", $def_curr->get('currency_id'),false);

  
  $role = new Role_Localized;
  $role->select(array("language_id" => $preferences["language"]));
  $roles = array();
  foreach($role as $key) {
    array_push($roles, array(
      'ROLE_LABEL'     => $role->get("name"),
      'ROLE_NAME'      => "role[".$role->get("role_id")."]",
      'ROLE_ACTIVE'    => ""));
  }
  $template->addRows('role',$roles);


  $conference = new Conference;
  if ($conference->select()) {
    fill_select("conference", $conference, "conference_id", "title", $preferences['conference']);
  }

  // get data for user interface language selection 
  $language = new Language_Localized;
  if ($language->select(array("language_id" => $preferences['language'])))
  {
    fill_select("language_list", $language, "translated_id", "name", 0);
  }
  

?>
