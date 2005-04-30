<?PHP
/**
 * patTemplate Reader that reads from a file
 *
 * $Id: File.php,v 1.12 2004/06/04 19:40:02 schst Exp $
 *
 * @package		patTemplate
 * @subpackage	Readers
 * @author		Stephan Schmidt <schst@php.net>
 */
 
/**
 * patTemplate Reader that reads from a file
 *
 * $Id: File.php,v 1.12 2004/06/04 19:40:02 schst Exp $
 *
 * @package		patTemplate
 * @subpackage	Readers
 * @author		Stephan Schmidt <schst@php.net>
 */
class patTemplate_Reader_File extends patTemplate_Reader
{
   /**
    * reader name
	* @access	private
	* @var		string
	*/
	var	$_name	=	'File';

   /**
	* flag to indicate, that current file is remote
	*
	* @access	private
	* @var		boolean
	*/
	var $_isRemote = false;
	
   /**
	* all files, that have been opened
	*
	* @access	private
	* @var		array
	*/
	var $_files = array();
	
   /**
    * read templates from any input 
	*
	* @final
	* @access	public
	* @param	string	file to parse
	* @return	array	templates
	*/
	function readTemplates( $input )
	{
		$this->_currentInput = $input;
		$fullPath	=	$this->_resolveFullPath( $input );
		if( patErrorManager::isError( $fullPath ) )
			return $fullPath;
		$content	=	$this->_getFileContents( $fullPath );
		if( patErrorManager::isError( $content ) )
			return $content;

		$templates	=	$this->parseString( $content );
		
		return	$templates;
	}

   /**
    * load template from any input 
    *
    * If the a template is loaded, the content will not get
    * analyzed but the whole content is returned as a string.
	*
	* @abstract	must be implemented in the template readers
	* @param	mixed	input to load from.
	*					This can be a string, a filename, a resource or whatever the derived class needs to read from
	* @return	string  template content
	*/
	function loadTemplate( $input )
	{
		$fullPath	=	$this->_resolveFullPath( $input );
		if( patErrorManager::isError( $fullPath ) )
			return $fullPath;
		return $this->_getFileContents( $fullPath );
	}

   /**
	* resolve path for a template
	*
	* @access	private
	* @param	string		filename
	* @return	string		full path
	*/	
	function _resolveFullPath( $filename )
	{
		if( preg_match( '/^[a-z]+:\/\//', $filename ) )
		{
			$this->_isRemote = true;
			return $filename;
		}
		/**
		 * local file
		 */
		else
		{
			$baseDir	=	$this->_options['root'];
			$fullPath	=	$baseDir . '/' . $filename;
		}
		return	$fullPath;
	}

   /**
	* get the contents of a file
	*
	* @access	private
	* @param	string		filename
	* @return	string		file contents
	*/	
	function _getFileContents( $file )
	{
		if( !$this->_isRemote && ( !file_exists( $file ) || !is_readable( $file ) ) )
		{
			return patErrorManager::raiseError(
										PATTEMPLATE_READER_ERROR_NO_INPUT,
										"Could not load templates from $file."
										);
		}
		
		if( function_exists( 'file_get_contents' ) )
			$content	=	@file_get_contents( $file );
		else
			$content	=	implode( '', file( $file ) );
			
		/**
		 * store the file name
		 */
		array_push( $this->_files, $file );
		
		return	$content;
	}
}
?>