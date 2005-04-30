<?php

  require_once('../db/view.php');

  class Union_Recent_Changes extends View
  {
    public function __construct()
    {
      $this->table = "transaction";
      $this->domain = "recent_changes";
      $this->field['type']['type'] = 'VARCHAR';
      $this->field['id']['type'] = 'INTEGER';
      $this->field['title']['type'] = 'VARCHAR';
      $this->field['changed_when']['type'] = 'DATETIME';
      $this->field['changed_by']['type'] = 'INTEGER';
      $this->field['name']['type'] = 'VARCHAR';
      $this->field['f_create']['type'] = 'BOOL';
      parent::__construct();
    }

    public function select($days)
    {
      $days = intval($days) > 0 ? intval($days) : 1;
      $sql = 
"SELECT 'conference' AS type, conference_transaction.conference_id AS id, conference.title AS title, conference_transaction.changed_when, conference_transaction.changed_by, coalesce(p.public_name, coalesce(p.first_name || ' ', '') || p.last_name, p.nickname, p.login_name) AS name , conference_transaction.f_create 
FROM conference_transaction, conference, person AS p
WHERE conference_transaction.changed_by = p.person_id AND conference_transaction.conference_id = conference.conference_id AND conference_transaction.changed_when > now() + '-$days day' 
UNION 
SELECT 'event' AS type, event_transaction.event_id AS id, event.title AS title, event_transaction.changed_when, event_transaction.changed_by, coalesce(p.public_name, coalesce(p.first_name || ' ', '') || p.last_name, p.nickname, p.login_name) AS name , event_transaction.f_create 
FROM event_transaction, person AS p, event
WHERE event_transaction.changed_by = p.person_id AND event_transaction.event_id = event.event_id AND changed_when > now() + '-$days day' 
UNION 
SELECT 'person' AS type, person_transaction.person_id AS id, coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name) AS title , person_transaction.changed_when, person_transaction.changed_by, coalesce(p.public_name, coalesce(p.first_name || ' ', '') || p.last_name, p.nickname, p.login_name) AS name , person_transaction.f_create 
FROM person_transaction, person AS p, person
WHERE person_transaction.changed_by = p.person_id AND person_transaction.person_id = person.person_id AND changed_when > now() + '-$days day' ORDER BY changed_when DESC;";
      return $this->real_select($sql);
    }
  
  }

?>
