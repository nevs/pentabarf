<?php

require_once("find.php");

/**
 * Class to easily access all information relevant to person.
*/
class Find_Person extends Find {

  /**
   * Constructor of the class.
  */
  public function __construct($select = array())
  {
    $this->table = "person";
    $this->domain = "person";
    $this->order = "lower(coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name))";
    $this->join = "";
    
    $this->search['person_id']['type'] = 'SUBSELECT';
    $this->search['person_id']['data'] = 'INTEGER';
    $this->search['person_id']['query'] = 'person.person_id {OP} ({STRING})';
    $this->search['name']['type'] = 'SIMPLE';
    $this->search['name']['data'] = 'TEXT';
    $this->search['name']['query'] = "( login_name {OP} {STRING} OR first_name {OP} {STRING} OR middle_name {OP} {STRING} OR last_name {OP} {STRING} OR public_name {OP} {STRING} OR nickname {OP} {STRING} )";
    $this->search['description']['type'] = 'SIMPLE';
    $this->search['description']['data'] = 'TEXT';
    $this->search['description']['query'] = '(person.abstract {OP} {STRING} OR person.description {OP} {STRING})';
    $this->search['keyword']['type'] = 'SUBSELECT';
    $this->search['keyword']['data'] = 'INTEGER';
    $this->search['keyword']['query'] = 'person.person_id IN (SELECT person_id FROM person_keyword WHERE keyword_id {OP} ({STRING}))';
    $this->search['phone']['type'] = 'SIMPLE';
    $this->search['phone']['data'] = 'TEXT';
    $this->search['phone']['query'] = 'person.person_id IN (SELECT person_id FROM person_phone WHERE phone_number {OP} {STRING})';

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
    $this->field['bank_name']['type'] = 'VARCHAR';
    $this->field['bank_name']['table'] = 'person';
    $this->field['account_owner']['type'] = 'VARCHAR';
    $this->field['account_owner']['table'] = 'person';
    $this->field['abstract']['type'] = 'TEXT';
    $this->field['abstract']['table'] = 'person';
    $this->field['description']['type'] = 'TEXT';
    $this->field['description']['table'] = 'person';
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

  public function select_watched($person_id) 
  {
    $watched = new Person_Watchlist_Person;
    $watched->select(array('person_id' => $person_id));
    $persons = array();
    foreach($watched as $v) {
      array_push($persons, $watched->get('watched_person_id'));
    } 
    return $this->select(array('person_id' => $persons));
  }
}

?>
