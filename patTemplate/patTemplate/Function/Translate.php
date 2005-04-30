<?PHP
/**
 * patTemplate function that emulates gettext's behaviour
 * 
 * This can be used to create multi-lingual websites.
 * When the template is read, all texts inside the
 * Translation tags are extracted and written to a file
 * called '$tmplname-default.ini'. 
 *
 * You should copy this file and translate all sentences.
 * When the template is used the next time, the sentences
 * will be replaced with their respective translations,
 * according to the langanuge you set with:
 * <code>
 * $tmpl->setOption( 'lang', 'de' );
 * </code>
 *
 * $Id: Translate.php,v 1.5.4.1 2004/10/27 11:23:49 schst Exp $
 *
 * @package		patTemplate
 * @subpackage	Functions
 * @author		Stephan Schmidt <schst@php.net>
 */

/**
 * patTemplate function that emulates gettext's behaviour
 * 
 * This can be used to create multi-lingual websites.
 * When the template is read, all texts inside the
 * Translation tags are extracted and written to a file
 * called '$tmplname-default.ini'. 
 *
 * You should copy this file and translate all sentences.
 * When the template is used the next time, the sentences
 * will be replaced with their respective translations,
 * according to the langanuge you set with:
 * <code>
 * $tmpl->setOption( 'lang', 'de' );
 * </code>
 *
 * $Id: Translate.php,v 1.5.4.1 2004/10/27 11:23:49 schst Exp $
 *
 * @package		patTemplate
 * @subpackage	Functions
 * @author		Stephan Schmidt <schst@php.net>
 * @todo		add error management
 */
class patTemplate_Function_Translate extends patTemplate_Function
{
   /**
	* name of the function
	* @access	private
	* @var		string
	*/
	var $_name	=	'Translate';

   /**
	* configuration of all files
	*
	* @access	private
	* @var		array
	*/
	var $_config	=	array();

   /**
	* global config
	*
	* @access	private
	* @var		array
	*/
	var $_globalconfig	=	array();

   /**
	* list of all sentences
	*
	* @access	private
	* @var		array
	*/
	var $_sentences	=	array();
	
   /**
	* translations of the language files
	*
	* @access	private
	* @var		array
	*/
	var $_translation = array();

   /**
    * reference to the patTemplate object that instantiated the module
	*
	* @access	protected
	* @var	object
	*/
	var	$_tmpl;

   /**
    * set a reference to the patTemplate object that instantiated the reader
	*
	* @access	public
	* @param	object		patTemplate object
	*/
	function setTemplateReference( &$tmpl )
	{
		$this->_tmpl		=	&$tmpl;
	}

   /**
	* call the function
	*
	* @access	public
	* @param	array	parameters of the function (= attributes of the tag)
	* @param	string	content of the tag
	* @return	string	content to insert into the template
	*/ 
	function call( $params, $content )
	{
		/**
		 * nothing to translate
		 */
		if( empty( $content ) )
		{
			return;
		}

		if( empty( $this->_globalconfig ) )
			$this->_retrieveGlobalConfig();
		
		$input = $this->_reader->getCurrentInput();
		
		/**
		 * get config
		 */
		if( empty( $this->_config[$input] ) )
		{
			$this->_retrieveConfig( $input );
			$this->_loadTranslationFile( $input );
		}

		/**
		 * unique key for the sentence to translate
		 */
		if( isset( $params['key'] ) )
			$key	=	$params['key'];
		else
			$key	=	md5( $content );
		
		/**
		 * does this already exists?
		 */
		if( !isset( $this->_sentences[$input][$key] ) )
		{
			$this->_sentences[$input][$key]	=	$content;
			$this->_addToTranslationFile( $input, $key, $content );
		}
		
		/**
		 * has it been translated?
		 */
		if( isset( $this->_translation[$input][$key] ) )
		{
			return $this->_translation[$input][$key];
		}

		/**
		 * use original sentence
		 */
		return $this->_sentences[$input][$key];
	}

   /**
	* get the global configuration
	*
	* This method fetches the selected language and the translation folder
	* as it is shared by all templates.
	*
	* @access	private
	* @return	boolean		currently always returns true
	*/
	function _retrieveGlobalConfig()
	{
		/**
		 * get config values from patTemplate
		 */
		$this->_globalconfig['lang'] = $this->_tmpl->getOption( 'lang' );
		if( !is_array( $this->_globalconfig['lang'] ) )
		{
			if( $this->_globalconfig['lang'] == 'auto' )
				$this->_globalconfig['lang'] = $this->_guessLanguage();
			else
				$this->_globalconfig['lang'] = array( $this->_globalconfig['lang'] );
		}
		
		$this->_globalconfig['translationFolder'] = $this->_tmpl->getOption( 'translationFolder' );
		
		return true;
	}
	
   /**
	* retrieve configuration
	*
	* This method sets the used files and loads the original sentence file, if it exists.
	*
	* @access	private
	* @param	string		current input that is used by patTemplate
	* @return	boolean		true on success
	*/
	function _retrieveConfig( $input )
	{
		if( !is_array( $this->_config ) )
			$this->_config	=	array();

		$this->_config[$input] = array();
		$this->_sentences[$input] = array();
		
		$this->_config[$input]['sentenceFile']		=	$this->_tmpl->getOption( 'translationFolder' ) . '/'.$input.'-default.ini';
		$this->_config[$input]['langFile']			=	$this->_tmpl->getOption( 'translationFolder' ) . '/'.$input.'-%s.ini';

		/**
		 * get the 'gettext' source file
		 */
		$this->_sentences[$input]	=	@parse_ini_file( $this->_config[$input]['sentenceFile'] );
		if( !is_array( $this->_sentences[$input] ) )
			$this->_sentences[$input] = array();
		else
			$this->_sentences[$input] = array_map( array( $this, '_unescape' ), $this->_sentences[$input] );
		
		
		return true;
	}

   /**
	* load the translation file
	*
	* @access	private
	* @param	string		current input that is used by patTemplate
	* @return	boolean		true on success
	*/
	function _loadTranslationFile( $input )
	{
		foreach( $this->_globalconfig['lang'] as $lang )
		{
			$translationFile	=	sprintf( $this->_config[$input]['langFile'], $lang );
			if( !file_exists( $translationFile ) )
				continue;
			$tmp	=	@parse_ini_file( $translationFile );
			if( is_array( $tmp ) )
			{
				$tmp = array_map( array( $this, '_unescape' ), $tmp );
				$this->_translation[$input]	=	$tmp;
				return true;
			}
		}
		return false;
	}

   /**
	* unsecape the text that has been read from the translation file
	*
	* @access	private
	* @param	string
	* @return	string
	*/
	function _unescape( $text )
	{
		return str_replace( '&quot;', '"', $text );
	}
	
   /**
  	* add a new sentence to the translation file
	*
	* @access	private
	* @param	string	unique key
	* @param	string	sentence to translate
	* @return	boolean
	*/
	function _addToTranslationFile( $input, $key, $content )
	{
		$fp	=	@fopen( $this->_config[$input]['sentenceFile'], 'a' );
		if( !$fp )
			return false;
		flock( $fp, LOCK_EX );
		fputs( $fp, sprintf( '%s = "%s"'."\n", $key, str_replace( '"', '&quot;', $content ) ) );
		flock( $fp, LOCK_UN );
		fclose( $fp );
		return true;
	}

   /**
	* guess the language
	*
	* @access	private
	* @return	array		array containing all accepted languages
	*/
	function _guessLanguage()
	{
		if( !preg_match_all( '/([a-z\-]*)?[,;]/i', $_SERVER['HTTP_ACCEPT_LANGUAGE'], $matches) )
		{
			return array();
		}
		$langs = array();
		foreach( $matches[1] as $lang )
		{
			if( empty( $lang ) )
				continue;
			array_push( $langs, $lang );
		}
		return $langs;
	}
}
?>