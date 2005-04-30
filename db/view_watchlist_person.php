<?php

  require_once('../db/view.php');

  class View_Watchlist_Person extends View
  {
  
    public function __construct($select = array())
    {
      $this->table = "person_watchlist_person, person";
      $this->domain = "person";
      $this->order = "lower(coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name))";
      $this->join = "person.person_id = person_watchlist_person.watched_person_id";

      $this->field['person_id']['type'] = 'SERIAL';
      $this->field['person_id']['name'] = 'person_watchlist_person.watched_person_id';
      $this->field['watcher_person_id']['type'] = 'SERIAL';
      $this->field['watcher_person_id']['name'] = 'person_watchlist_person.person_id';
      $this->field['watched_person_id']['type'] = 'SERIAL';
      $this->field['watched_person_id']['table'] = 'person_watchlist_person';
      
      $this->field['name']['type'] = 'VARCHAR';
      $this->field['name']['name'] = 'coalesce(person.public_name, coalesce(person.first_name || \' \', \'\') || person.last_name, person.nickname, person.login_name)';
      
      
      parent::__construct($select);
    }
  
  }
  

?>
