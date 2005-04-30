<?php

  require_once("../classes/jabber.php");
  require_once("../db/auth_person.php");

  class Privilege_Exception extends Exception {}

  // general exception handler 
  function Exception_Handler($exception)
  {
    trigger_error("Uncaught Exception: ".$exception->getMessage()."\nFile: ".$exception->getFile()." Line: ".$exception->getLine()."\nTrace:\n".$exception->getTraceAsString());
    
    // initialize template engine
    $template = new patTemplate;
    $template->setBasedir('../templates');
    $template->readTemplatesFromFile('error.tmpl');

    if ( $exception instanceof Privilege_Exception) {
      $template->addVar( "popup" , "MESSAGE", "I am sorry but you are not allowed to do this." );
    }
    
    $template->displayParsedTemplate("main");
    
    exit;
  }

  set_exception_handler("Exception_Handler");



?>
