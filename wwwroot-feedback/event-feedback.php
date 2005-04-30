<?PHP

  require_once('../functions/error_handler.php');
  require_once('../patError/patErrorManager.php');
  require_once('../patTemplate/patTemplate.php');
  require_once('../db/auth_public.php');
  require_once('../db/view_fahrplan_event.php');
  require_once('../db/event_rating_public.php');

  // authenticate Person
  $auth_person = new Auth_Public;
  
  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);
  $BASE_URL = str_replace("index.php","",$_SERVER['SCRIPT_NAME']);

  // initialize template engine
  $template = new patTemplate;
  $template->applyInputFilter('Translate');
  $template->setBasedir("../templates");
  $template->addGlobalVar("BASE_URL", $BASE_URL);

  $event = new View_Fahrplan_Event;
  if (!$VIEW || $event->select(array('event_id' => $VIEW, 'conference_id' => 1)) != 1) {
    // this event is not part of the fahrplan or part of this conference
    trigger_error('404 in Event Feedback');
    require_once('../wwwroot/error.html');
    exit;
  }
  
  if(isset($_POST['action']) && $_POST['action'] == 'save') {

    $rating = new Event_Rating_Public;
    $rating->create();
    $rating->set('event_id', $event->get('event_id'));
    foreach($rating->get_field_names() as $field) {
      if (isset($_POST[$field])) {
        if ($rating->get_type($field) == 'SMALLINT') {
          if ($_POST[$field] > 5) $_POST[$field] = 5;
          if ($_POST[$field] < 0) $_POST[$field] = 0;
        }
        $rating->set($field, $_POST[$field]);
      }
    }
    $rating->set('rater_ip', $_SERVER['REMOTE_ADDR']);
    $rating->write();
    $template->readTemplatesFromFile("feedback-done.tmpl");
    $template->addVar('main','EVENT_ID',$event->get('event_id'));
    $template->addVar('main','EVENT_TITLE',$event->get('title'));
    $template->displayParsedTemplate("main");
    exit;

  } else {
  
    $template->readTemplatesFromFile("feedback.tmpl");

    $template->addVar('main','EVENT_TITLE',$event->get('title'));
    $template->addVar('main','EVENT_SUBTITLE',$event->get('subtitle'));
    $template->addVar('main','EVENT_ABSTRACT',$event->get('abstract'));

    $template->displayParsedTemplate("main");

  }

?>
