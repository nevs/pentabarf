<?php

require_once("view.php");

/**
 * Class to easily access all information relevant to person.
*/
class View_Person extends View {

  /**
   * Constructor of the class.
  */
  public function __construct($select = array())
  {
    $this->table = "person";
    $this->domain = "person";
    $this->order = "lower(coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name))";
    $this->join = "";
    $this->field['person_id']['type'] = 'SERIAL';
    $this->field['person_id']['table'] = 'person';
    $this->field['login_name']['type'] = 'VARCHAR';
    $this->field['login_name']['table'] = 'person';
    $this->field['password']['type'] = 'CHAR';
    $this->field['password']['table'] = 'person';
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['table'] = 'person';
    $this->field['gender']['type'] = 'BOOL';
    $this->field['gender']['table'] = 'person';
    $this->field['first_name']['type'] = 'VARCHAR';
    $this->field['first_name']['table'] = 'person';
    $this->field['middle_name']['type'] = 'VARCHAR';
    $this->field['middle_name']['table'] = 'person';
    $this->field['last_name']['type'] = 'VARCHAR';
    $this->field['last_name']['table'] = 'person';
    $this->field['public_name']['type'] = 'VARCHAR';
    $this->field['public_name']['table'] = 'person';
    $this->field['nickname']['type'] = 'VARCHAR';
    $this->field['nickname']['table'] = 'person';
    $this->field['address']['type'] = 'VARCHAR';
    $this->field['address']['table'] = 'person';
    $this->field['street']['type'] = 'VARCHAR';
    $this->field['street']['table'] = 'person';
    $this->field['street_postcode']['type'] = 'VARCHAR';
    $this->field['street_postcode']['table'] = 'person';
    $this->field['po_box']['type'] = 'VARCHAR';
    $this->field['po_box']['table'] = 'person';
    $this->field['po_box_postcode']['type'] = 'VARCHAR';
    $this->field['po_box_postcode']['table'] = 'person';
    $this->field['city']['type'] = 'VARCHAR';
    $this->field['city']['table'] = 'person';
    $this->field['country_id']['type'] = 'INTEGER';
    $this->field['country_id']['table'] = 'person';
    $this->field['email_contact']['type'] = 'VARCHAR';
    $this->field['email_contact']['table'] = 'person';
    $this->field['email_public']['type'] = 'VARCHAR';
    $this->field['email_public']['table'] = 'person';
    $this->field['iban']['type'] = 'VARCHAR';
    $this->field['iban']['table'] = 'person';
    $this->field['bic']['type'] = 'VARCHAR';
    $this->field['bic']['table'] = 'person';
    $this->field['bank_name']['type'] = 'VARCHAR';
    $this->field['bank_name']['table'] = 'person';
    $this->field['account_owner']['type'] = 'VARCHAR';
    $this->field['account_owner']['table'] = 'person';
    $this->field['abstract']['type'] = 'TEXT';
    $this->field['abstract']['table'] = 'person';
    $this->field['description']['type'] = 'TEXT';
    $this->field['description']['table'] = 'person';
    $this->field['gpg_key']['type'] = 'TEXT';
    $this->field['gpg_key']['table'] = 'person';
    $this->field['remark']['type'] = 'TEXT';
    $this->field['remark']['table'] = 'person';
    $this->field['preferences']['type'] = 'PREFERENCES';
    $this->field['preferences']['table'] = 'person';
    $this->field['f_conflict']['type'] = 'BOOL';
    $this->field['f_conflict']['table'] = 'person';
    $this->field['f_deleted']['type'] = 'BOOL';
    $this->field['f_deleted']['table'] = 'person';
    $this->field['last_login']['type'] = 'TIMESTAMP';
    $this->field['last_login']['table'] = 'person';
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['name'] = 'coalesce(person.public_name, coalesce(person.first_name || \' \', \'\') || person.last_name, person.nickname, person.login_name)';
    parent::__construct($select);

  }

}

?>
