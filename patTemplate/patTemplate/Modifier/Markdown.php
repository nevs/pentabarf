<?php

  require_once('../functions/markdown.php');

  class patTemplate_Modifier_Markdown extends patTemplate_Modifier
  {
    function modify( $value, $params = array() )
    {
      return Markdown(str_replace(array('"', '<', '>'), array('&quot;', '&lt;', '&gt;'), $value));
    }
  }

?>
