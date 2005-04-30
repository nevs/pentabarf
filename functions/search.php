<?php

  function compare_search($a, $b) 
  {
    if (!isset($a['type']) || !isset($b['type'])) return 0;
    if (strcmp($a['type'], $b['type'])) {
      return strcmp($a['type'], $b['type']);
    } else if (strcmp($a['logic'], $b['logic'])) {
      return strcmp($a['logic'], $b['logic']);
    } else {
      return strcmp($a['value'], $b['value']);
    }
  }

?>
