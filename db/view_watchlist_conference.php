<?php

  require_once('../db/view.php');

  class View_Watchlist_Conference extends View
  {
  
    public function __construct($select = array())
    {
      $this->table = "person_watchlist_conference, conference";
      $this->domain = "conference";
      $this->order = "lower(conference.title), lower(conference.subtitle)";
      $this->join = "person_watchlist_conference.conference_id = conference.conference_id";

      $this->field['person_id']['type'] = 'SERIAL';
      $this->field['person_id']['table'] = 'person_watchlist_conference';
      $this->field['conference_id']['type'] = 'SERIAL';
      $this->field['conference_id']['table'] = 'person_watchlist_conference';
      
      $this->field['acronym']['type'] = 'VARCHAR';
      $this->field['acronym']['table'] = 'conference';
      $this->field['title']['type'] = 'VARCHAR';
      $this->field['title']['table'] = 'conference';
      $this->field['subtitle']['type'] = 'VARCHAR';
      $this->field['subtitle']['table'] = 'conference';
      
      parent::__construct($select);
    }
  
  }
  

?>
