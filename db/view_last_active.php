<?php

require_once("view.php");

/**
 * Class to easily access all information relevant to person.
*/
class View_Last_Active extends View {

  /**
   * Constructor of the class.
  */
  public function __construct($select = array())
  {
    $this->table = "person";
    $this->domain = "person";
    $this->order = "person.last_login DESC";
    $this->join = "last_login > now() + '-1 hour'::interval AND person.person_id <> {$this->get_auth_person_id()}";
    $this->field['person_id']['type'] = 'SERIAL';
    $this->field['person_id']['table'] = 'person';
    $this->field['login_name']['type'] = 'VARCHAR';
    $this->field['login_name']['table'] = 'person';
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['name'] = 'coalesce(person.public_name, coalesce(person.first_name || \' \', \'\') || person.last_name, person.nickname, person.login_name)';
    $this->field['login_diff']['type'] = 'INTERVAL';
    $this->field['login_diff']['name'] = 'now() - person.last_login';
    parent::__construct($select);

  }

}

?>
