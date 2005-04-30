<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_timestamp.php');
require_once('../classes/database/datatypes/dt_smallint.php');
require_once('../classes/database/datatypes/dt_inet.php');

/// class for accessing and manipulating content of table event_rating_public
class EVENT_RATING_PUBLIC extends DB_BASE
{
   /// constructor of the class event_rating_public
   public function __construct()
   {
      parent::__construct();
      $this->table = 'event_rating_public';
      $this->domain = 'event_rating_public';
      $this->limit = 0;
      $this->order = '';

      $this->fields['event_id'] = new DT_INTEGER( $this, 'event_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['rater_ip'] = new DT_INET( $this, 'rater_ip', array(), array() );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
      $this->fields['audience_involvement'] = new DT_SMALLINT( $this, 'audience_involvement', array(), array() );
      $this->fields['presentation_quality'] = new DT_SMALLINT( $this, 'presentation_quality', array(), array() );
      $this->fields['eval_time'] = new DT_TIMESTAMP( $this, 'eval_time', array(), array('DEFAULT' => true, 'NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['content_quality'] = new DT_SMALLINT( $this, 'content_quality', array(), array() );
      $this->fields['participant_knowledge'] = new DT_SMALLINT( $this, 'participant_knowledge', array(), array() );
      $this->fields['topic_importance'] = new DT_SMALLINT( $this, 'topic_importance', array(), array() );
   }

}

?>
