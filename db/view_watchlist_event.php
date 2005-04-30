<?php

  require_once('../db/view.php');

  class View_Watchlist_Event extends View
  {
  
    public function __construct($select = array())
    {
      $this->table = "person_watchlist_event, event";
      $this->domain = "person";
      $this->order = "lower(event.title), lower(event.subtitle)";
      $this->join = "person_watchlist_event.event_id = event.event_id";

      $this->field['person_id']['type'] = 'SERIAL';
      $this->field['person_id']['table'] = 'person_watchlist_event';
      $this->field['event_id']['type'] = 'SERIAL';
      $this->field['event_id']['table'] = 'person_watchlist_event';
      
      $this->field['title']['type'] = 'VARCHAR';
      $this->field['title']['table'] = 'event';
      $this->field['subtitle']['type'] = 'VARCHAR';
      $this->field['subtitle']['table'] = 'event';
      $this->field['conference_id']['type'] = 'INTEGER';
      $this->field['conference_id']['table'] = 'event';
      $this->field['event_state_id']['type'] = 'INTEGER';
      $this->field['event_state_id']['table'] = 'event';
      
      parent::__construct($select);
    }
  
  }
  

?>
