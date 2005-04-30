<?php

  function xmlentities($text)
  {
    return str_replace(array('<','>','&'),array('&lt;','&gt;','&amp;'),$text);
  }

?>
