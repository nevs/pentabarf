<?php
    
  require_once('../functions/error_handler.php');
  require_once('../db/auth_person.php');
  require_once('../db/view_person.php');
  require_once('../db/view_person_phone.php');
  require_once('../db/view_person_im.php');
  require_once('../db/country_localized.php');
  require_once('../db/person_image.php');
  require_once('../db/mime_type.php');
  require_once('Contact_Vcard_Build.php');
  
  $auth_person = new Auth_Person;
  
  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);

  $vcard = new Contact_Vcard_Build;
  $vcard->setVersion('3.0');
  $person = new View_Person;
  if ($person->select(array('person_id' => $RESOURCE)) != 1) {
    throw new Exception("404 in vcard.php",1);
  }
  
  $vcard->setFormattedName($person->get('name'));

  
  if ($person->get('nickname')) {
    $vcard->addNickname($person->get('nickname'));
  }
  
  // set the structured name parts
  $vcard->setName($person->get('last_name'), $person->get('first_name'), $person->get('middle_name'), '',$person->get('title'));
  
  $vcard->addEmail($person->get('email_public'));
  $vcard->addParam('TYPE', 'WORK');
  
  $vcard->addEmail($person->get('email_contact'));
  $vcard->addParam('TYPE', 'HOME');
  $vcard->addParam('TYPE', 'PREF');

  
  $photo = new Person_Image;
  if ($photo->select(array('person_id' => $person->get('person_id')))) {
    // Image exists
    $mime_type = new MIME_Type;
    $mime_type->select(array('mime_type_id' => $photo->get('mime_type_id')));
    $mime_type = strtoupper(str_replace("image/", "", $mime_type->get('mime_type')));
    $vcard->setPhoto(base64_encode($photo->get('image')));
    $vcard->addParam('ENCODING', 'b');
    $vcard->addParam('TYPE', $mime_type);
  }
  
  if ($person->get('country_id')) {
    $country = new Country_Localized;
    if ($country->select(array('country_id' => $person->get('country_id'), 'language_id' => 144)) == 1) {
      $country = $country->get('name');
    } 
  }
  // add a work address  parameter: po_box | extension | street | locality | region | postcode | country
  $vcard->addAddress('', $person->get('address'), $person->get('street'), $person->get('city'), '', $person->get('street_postcode'), isset($country) ? $country : '');
  $vcard->addParam('TYPE', 'HOME');

  if ($person->get('po_box')) { // add po box if available
    $vcard->addAddress($person->get('po_box'), '', '', $person->get('city'), '', $person->get('po_box_postcode'), isset($country) ? $country : '');
    $vcard->addParam('TYPE', 'HOME');
  }

  // get phone numbers 
  $phone = new View_Person_Phone;
  $phone->select(array('person_id' => $person->get('person_id')));
  
  foreach($phone as $v) {
    $vcard->addTelephone($phone->get('phone_number'));
    switch($phone->get('phone_type_tag')) {
      case 'mobile':
        $vcard->addParam('TYPE', 'CELL');
        break;
      case 'work': case 'secretary':
        $vcard->addParam('TYPE', 'WORK');
        break;
      case 'private': case 'phone':
        $vcard->addParam('TYPE', 'HOME');
        break;
      case 'fax':
        $vcard->addParam('TYPE', 'FAX');
        break;
        
    }
  }
  
  $im = new View_Person_IM;
  $im->select(array('person_id' => $person->get('person_id')));
  $im_type_count = array();
  foreach($im as $v) {
    switch($im->get('im_type_tag')) {
      case 'icq':
        $type_name = 'X-ICQ';
        break;
      case 'aim':
        $type_name = 'X-AIM';
        break;
      case 'jabber':
        $type_name = 'X-JABBER';
        break;
      case 'msn':
        $type_name = 'X-MSN';
        break;
      case 'yahoo':
        $type_name = 'X-YAHOO';
        break;
      default:
        continue 2;
    }
    if (isset($im_type_count[$im->get('im_type_tag')])) {
      $im_type_count[$im->get('im_type_tag')] += 1;
    } else {
      $im_type_count[$im->get('im_type_tag')] = 0;
    }
    $vcard->addValue($type_name, $im_type_count[$im->get('im_type_tag')], 0, $im->get('im_address'));
    $vcard->addParam('TYPE', 'HOME');
  }

  // send the vcard
  // echo $vcard->fetch();
  $vcard->send("person{$person->get('person_id')}.vcf", 'inline', 'utf-16');
    
?>
