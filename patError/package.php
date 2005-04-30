<?php
/**
 * package.xml generation file for patForms
 *
 * $Id: package.php,v 1.1 2004/04/06 21:03:35 gerd Exp $
 *
 * @author    Stephan Schmidt <schst@php-tools.net>
 * @author    gERD Schaufelberger <gerd@php-tools.net>
 * @package    pat
 * @subpackage  patTools
 */

/**
 * uses the great PEAR_PackageFileManager
 * praise Greg Beaver!!
 */
  require_once('PEAR/PackageFileManager.php');
  
  $packageDir  =  dirname( __FILE__ );
  
  $packagexml = new PEAR_PackageFileManager;
  
  $e = $packagexml->setOptions(
      array(
        'baseinstalldir'    =>  'pat',
        'version'        =>  '1.0.2',
        'packagedirectory'    =>  $packageDir,
        'state'          =>  'beta',
        'filelistgenerator'    =>  'cvs', // generate from cvs, use file for directory
        'notes'          =>  'new features for ignoring errors',
        'ignore'        =>  array('package.xml', 'package.php', '.cvsignore' ),
        'installexceptions'    =>  array(), // baseinstalldir ="/" for phpdoc
        'dir_roles'        =>  array('examples' => 'doc', 'docs' => 'doc' ),
        'file_roles'      =>  array(),
        'exceptions'      =>  array()
      )
    );
  if( PEAR::isError( $e ) ) 
  {
    echo $e->getMessage();
    die();
  }

  // note use of  - this is VERY important
  if( isset( $_GET['make'] ) || $_SERVER['argv'][2] == 'make' ) 
  {
    $e = $packagexml->writePackageFile();
  } 
  else 
  {
    $e = $packagexml->debugPackageFile();
  }
  
  if( PEAR::isError( $e ) ) 
  {
    echo $e->getMessage();
    die();
  }
?>
