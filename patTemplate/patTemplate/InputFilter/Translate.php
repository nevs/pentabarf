<?PHP

  require_once('../db/view_ui_message.php');

/**
 * Inputfilter for translating a page.
 *
 */

class patTemplate_InputFilter_Translate extends patTemplate_InputFilter
{
  var  $_name  =  'Translate';

  function apply( $data )
  {
    $matches = array();
    if (preg_match_all('/<\[([-a-z_]+)\]>/', $data, $matches)) {
      try {
        $messages = new View_UI_Message;
        $messages->select(array('tag' => $matches[1], 'language_id' => $messages->get_language_id()));
        foreach($messages as $key) {
          $data = str_replace('<['.$messages->get('tag').']>', htmlspecialchars($messages->get('name')), $data);
        }
      } catch(Exception $e) {
        trigger_error("Error while Saving: ".$e->getMessage()."\nFile: ".$e->getFile()." Line: ".$e->getLine()."\nTrace:\n".$e->getTraceAsString());
      }
    }
    return $data;
  }
}
?>
