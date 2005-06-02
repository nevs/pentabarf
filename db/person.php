<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person.
*/

class Person extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person";
    $this->order = "lower(coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name))";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'SERIAL';
    $this->field['person_id']['not_null'] = true;
    $this->field['login_name']['type'] = 'VARCHAR';
    $this->field['login_name']['length'] = 32;
    $this->field['password']['type'] = 'PASSWORD';
    $this->field['password']['length'] = 48;
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['length'] = 32;
    $this->field['gender']['type'] = 'BOOL';
    $this->field['first_name']['type'] = 'VARCHAR';
    $this->field['first_name']['length'] = 64;
    $this->field['middle_name']['type'] = 'VARCHAR';
    $this->field['middle_name']['length'] = 64;
    $this->field['last_name']['type'] = 'VARCHAR';
    $this->field['last_name']['length'] = 64;
    $this->field['public_name']['type'] = 'VARCHAR';
    $this->field['public_name']['length'] = 64;
    $this->field['nickname']['type'] = 'VARCHAR';
    $this->field['nickname']['length'] = 64;
    $this->field['address']['type'] = 'VARCHAR';
    $this->field['address']['length'] = 64;
    $this->field['street']['type'] = 'VARCHAR';
    $this->field['street']['length'] = 64;
    $this->field['street_postcode']['type'] = 'VARCHAR';
    $this->field['street_postcode']['length'] = 10;
    $this->field['po_box']['type'] = 'VARCHAR';
    $this->field['po_box']['length'] = 10;
    $this->field['po_box_postcode']['type'] = 'VARCHAR';
    $this->field['po_box_postcode']['length'] = 10;
    $this->field['city']['type'] = 'VARCHAR';
    $this->field['city']['length'] = 64;
    $this->field['country_id']['type'] = 'INTEGER';
    $this->field['email_contact']['type'] = 'VARCHAR';
    $this->field['email_contact']['length'] = 64;
    $this->field['email_public']['type'] = 'VARCHAR';
    $this->field['email_public']['length'] = 64;
    $this->field['iban']['type'] = 'VARCHAR';
    $this->field['iban']['length'] = 128;
    $this->field['bic']['type'] = 'VARCHAR';
    $this->field['bic']['length'] = 11;
    $this->field['bank_name']['type'] = 'VARCHAR';
    $this->field['bank_name']['length'] = 128;
    $this->field['account_owner']['type'] = 'VARCHAR';
    $this->field['account_owner']['length'] = 128;
    $this->field['abstract']['type'] = 'TEXT';
    $this->field['description']['type'] = 'TEXT';
    $this->field['gpg_key']['type'] = 'TEXT';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['preferences']['type'] = 'PREFERENCES';
    $this->field['f_conflict']['type'] = 'BOOL';
    $this->field['f_conflict']['not_null'] = true;
    $this->field['f_conflict']['default'] = true;
    $this->field['f_deleted']['type'] = 'BOOL';
    $this->field['f_deleted']['not_null'] = true;
    $this->field['f_deleted']['default'] = true;
    $this->field['last_login']['type'] = 'TIMESTAMP';
    $this->field['person_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
