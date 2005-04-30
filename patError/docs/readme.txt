/**
 * patError - simple and powerful error managemet system
 *
 * This is based on the PEAR error handling, if you like it
 * you should try some PEAR classes available at
 * http://pear.php.net
 * 
 * $Id: readme.txt,v 1.3 2004/04/06 20:45:59 gerd Exp $
 *
 * @access		public
 * @package		patError
 *
 * @copyright	2003/2004 by the patTeam
 * @author		gERD Schaufelberger <gerd@php-tools.net>
 * @author		Sebastian Mordziol <argh@php-tools.net>
 * @author		Stephan Schmidt <schst@php-tools.net>
 * @license		LGPL
 * @link		http://www.php-tools.net
 * @todo		explain: custom error handler, custom error class, some more notes about error codes
 */

Download at http://www.php-tools.net

This program and all associated files are released under the GNU Lesser Public License,
see http://www.gnu.org/licenses/lgpl.txt for details!

WHAT IS PATERROR?
=================
Inspired by the PEAR error handling, patError tries to solve the problem of handling 
runtime-errors within your PHP-projects. Therefore patError supplies the developer with 
a simple interface for "throwing" errors or sending error-objects as return values. On 
the other side the errors are "catched" automatically by the registered error-handler. 

patError also supports different error-levels. The three well-known error levels: "notice", 
"warning" and "error" are built-in and can be used without further configuration. patError
also includes predefined default-behaviour for each of these error levels. 

Beside these built-in error-levels, you can register your custom error levels during runtime. 
While switching from "developing" and "testing" stage to "productive" you may also want to change
the error-handling from "verbose" to a more silent mode. For these purposes patError supports
six different modes of error-handling: 
 - ignore (does nothing)
 - trigger (triggers the corresponding php-error)
 - echo (prints error-level and -message)
 - verbose (like echo, but prints also the error-information-text)
 - callback (calls a user-function)
 - die (dies with error-message)

The "callback"-handler is the most powerful error-handler. While all the other methods are built-in
functions of patError (or, to be more exactly: of patErrorManager), the callback-handler just 
calls a registered user-function for error-treatment. So you can write your own error-handling 
classes/functions suitable for your application. E.g. custom error-handlers can be used to write
log files or send emails. 

As mentioned above, a common need is to switch from one error-handling to another. E.g. a suitable
error-handler during the develoment process will echo a lot of information direct to the output. 
Later, in a productive environment error-handling should be done more hidden - there is no need 
bothering a visitor with strange warnings...
With patError you can switch the error-handling very easy by registering another error-handler for
each error-level.

WHY USE PATERROR?
=================
1) patError is object oriented
   The manager returns error-objects that can be handled very easy
   
2) Static API
   The patErrorManager supports a static interface for configuration and
   raising errors. So you don't have juggle object references inside you application
   
3) Easy to use
   Just say: "patErrorManager::raiseError( 123, 'My personal error', 'Some more information' );"
   The complete API consists of ten functions:
    - Three of them are for configuration purpose: setErrorClass, setErrorHandling, registerErrorLevel
	- Two utility functions: getErrorHandling, translateErrorLevel
    - Four methods for raising errors: raise, raiseError, raiseWarning, raiseNotice
	- One for checking returned values: isError
	
4) Easy to install and integrate
   You just need two files copied into you include directory, include one 
   and patErrorManager will to the rest.
   patError can also be installed via the PEAR installer.
   
5) patError is extensible
   patError allows to add custom error-handler. Implementing your own handler is very easy: 
   You just need a global function or an object that supports the error-handling function.

6) patError is free and open!
   Like the other pat-classes patError is free software and - of course - comes as source-code
   distribution. 
 
INSTALLATION
============
See install.txt for a basic set-up.

USAGE
=====
The package of patError consits of two main clases: patError and patErrorManager (located in the 
corresponding PHP-files). While patError implements the concrete error-class, the patErrorManager
will be used as a factory producing patError-objects.

1) Standard use-case
--------------------
Even if patError is designed for advanced programming, patError supports a very simple API. 
During programming the main task of patError will be fetching thrown errors. Throwing an error
is done by patErrorManager. 

Example:
<?PHP
	include_once 'include/patErrorManager.php';
	$err =& patErrorManager::raiseError( 111, 'Test', 'Testing patErrorManager' );
?>

The example above shows the standard use-case of patErrorManager. The static function 
raiseError accepts three arguments: 
 - unique error-number
 - a message
 - some additional information
 
The error-number and the messsage are obligatory, the additional information are optional.
Using unique error-numbers allows you to identify individual errors. See section ERROR CODES 
for more information about this topic. 
The message provided usually will printed by the error-handler. This message should give you some
information about the error. Keep in mind, that a visitor or smart customer may read 
this message (inside the HTML-code) - for reducing security risks you must not include filenames 
or even username (or even worse passwords) in the error-message. 
The third parameter contains additional information: the information part. It is recommended that
the information-part will never be shown to a visitor. This part should be only shown to the 
developer or maintainer. Therefore it should contain useful debugging information (e.g. SQL-query).

A more real-live example:
	$err =& patErrorManager::raiseWarning( 999,
                                   'Caching failed',
                                   'Cannot write cache file: "/path/to/file.cache" - permission denied!', 
								);

2) Return value: patError-object
--------------------------------
In both examples, the raiseXXX-functions return a patError-oject. Even if this object
has some public methods, you don't want to use them. Usually the the registerd error-handler 
cares for the information stored in the error-object. (By the way, the patError-object is just a 
container for the parameters passed to the raiseXXX-function - why should you ask for them?). 

On the other hand, the patError-object is very suitable as return value of a function call. 
If something went wrong, just raiseSOMETHING and return the patError-object. The caller can
use the static function "isError" for testing the return value:

Example: 
    // in the "main-routine" the answer must be checked:

    // include patErrorManager
    include_once 'patErrorManager.php';

    $result = checkAnswer( 41 );
    if( patErrorManager::isError( $result ) )
    {
        echo 'found error object!';
    }

   /**
    * imagine there is a glorious function,
    * this function returns TRUE if everything
    * went right or a patError-Object
    */
    function checkAnswer( $answer )
    {
        if( $answer != 42 )
        {
            return patErrorManager::raiseNotice( 42, 'Wrong Answer', "The Answer was '$answer', it should be 42"  );
        }
        return true;
    }

INGORE ERRORS
=============
Sometimes it is necessary to ignore errors or you call a some function which result 
usually results in an error. patError also supports ignoring errors in two different ways. 

Ignore Errors
-------------
The first and easiest way is to configure patError to ignore some errors permanently. For modifing
the configurations there are four class-methods: 
 - addIngore: add one or more codes to list
 - removeIgnore: remove one or more codes from list
 - getIgnore: recieve current configuration
 - clearIgnore: empty configuration
 
After adding error-codes to the ignore list, raising such an error will not result in an error.

Example: 
    // add a single error-code to be ingored
    patErrorManager::addIngore( 666 );
	
	// add list of error-codes
    patErrorManager::addIngore( array( 111, 222, 333, 444 ) );
	
	// try to raise an error
	$err =&	patErrorManager::raiseError( 666, 'Beast Error', 'The number of the beast is a bad error.' );
	if( !patErrorManager::isError( $err ) )
	{
		echo 'This error was ignored!';
	}
	
Expecting Errors
----------------
The second way of ignoring errors was designed for local usage. In contrast to ignoring errors
permanently, the idea of expecting errors allows you to ignore the next error if it belongs it 
was expected. This feature is controled by the functions:
 - pushExpect: add one ore more codes to expection-stack
 - popExpect: remove last entry from stack
 - getExpect: recieve expection-stack
 - clearExpect: empty stack
 
Example: 
    // push a single error-code to exeption-stack
    patErrorManager::pushExcept( 211 );
	
	// push list of error-codes to stack
    patErrorManager::pushExcept( array( 311, 322, 333, 344 ) );
	
	// try to raise an error
	$err =&	patErrorManager::raiseError( 322, 'Yet another error', 'Some error are not really special' );
	if( !patErrorManager::isError( $err ) )
	{
		echo 'This error was expected and ignored!';
	}
	
ADVANCED USAGE
==============
Even if the programming interface of patError is quite simple, it comes with a lot of advanced 
features. 

1) Wrapper functions
--------------------
If you want to become an advanced user of patError, you need to understand the internal mechanism
for throwing errors. 

The above examples showd functions, that can be used for raising errors. Beside their names 
the functions 
 - raiseError
 - raiseWarning
 - raiseNotice 
are nearly identical. In other words, they are just wrappers for the base function: "raise" for 
the predefined error-levels: "error", "warning" and "notice". 
Therefore the following call is identical to the first example:

	$err = patErrorManager::raise( E_ERROR, 111, 'Test', 'Testing patErrorManager' );

As you might guess, the build-in error-levels "error", "warning" and "notice" just reuse
the PHP core constants E_ERROR, E_WARNING and E_NOTICE. 

2) Configure Error Handling
---------------------------
Setting up patError will also be done using the static interface of patErrorManager. 
patError supports three types for configuration: 
  - Adding custom error-levels
  - Change the error-handling
  - Setting an custom error-class

2.1) Custom Error Levels
Using custom error-levels is quite simple. All you need is a number which defines your 
custom error-level. If you are lazy, you may use one of the predefined constants:
E_USER_ERROR, E_USER_WARNING, E_USER_NOTICE. Otherwise you have to make sure, that 
your selected error-level does not conflict with the build-in error-levels. Speaking
"binary", a CUSTEM_LEVEL must be chosen that fulfils the following expression:

      ( ( E_ERROR | E_WARNING | E_NOTICE ) & CUSTOM_LEVEL ) == 0

We recommend the usage of: E_USER_ERROR, E_USER_WARNING and/or E_USER_NOTICE !

After selection of, let's say E_USER_ERROR the error-level can be registered by the usage
of the function called: registerErrorLevel. Now the "new" error-level can be used as the
predefined. 

Example: 
    patErrorManager::registerErrorLevel( E_USER_ERROR, "User Error" );
	
    // raise build-in-error
    patErrorManager::raise( E_ERROR, 123, 'Build-in-error', 'Some information' );
    // raise custom error
    patErrorManager::raise( E_USER_ERROR, 123, 'Some custom error', 'Some custom information' );
	
ATTENTION:
As shown, the custom error-level can be used as the built-in error-levels. In order to avoid 
confusion, you have to keep in mind, that the error-handling of new error-levels is set to 'ignore'
by default! For changing this, see section: Change error-handling
	
2.2) Change error-handling
--------------------------
As mentioned in the introduction, patError supports six named methods of error-handling:
 - ignore (does nothing)
 - trigger (triggers the corresponding php-error)
 - echo (prints error-level and -message)
 - verbose (like echo, but prints also the error-information-text)
 - callback (calls a user-function)
 - die (dies with error-message)

The default method for the build-in error-levels are: 

 - E_NOTICE -> echo
 - E_WARNING -> echo
 - E_ERROR -> die
 
The default method for custom error-levels is 'ignore'. 

Changing the error-handling methos can be done during runtime - usually during the set-up process
of your application. Setting and configuring the error-handler will be done by the static function
setErrorHandling. This function accepts two or three arguments. The first arguemnt is the error-level, 
the second argument is the named method of error-handling and the third, optional parameter can
be used to add further options. 

Example: 
    patErrorManager::setErrorHandling( E_WARNING, 'verbose' );
    patErrorManager::setErrorHandling( E_NOTICE, 'ignore' );

In the above example, the error-level for E_WARNING and E_NOTICE will be changed to 'verbose'
and 'ignore'. The next example shows how to set multiple error-levels within a single function
call: 

    patErrorManager::setErrorHandling( ( E_WARNING | E_ERROR ), 'die' );
If you are not familiar with this syntax read the php-documetation about the function: error_reporting.

Of course, the most powerful error-handling method is the 'callback' method. Setting your
custom error-handler works like the examples above. All you have to add is a third parameter,
containing a 'call-able' value (see php-documentation about the function is_callable). 

The example below shows how to set an error-handler-object as error-handler for E_ERROR. 
For further information about custom error-handler see section. Custom error handler

    include_once 'include/patErrorHandlerDebug.php';
    $errorHandler	=&	new	patErrorHandlerDebug;

    // setup handler for each error-level
    patErrorManager::setErrorHandling( E_ERROR, 'callback', array( $errorHandler, 'niceDie' ) );


2.3) Custom error class
-----------------------

3) Custom error handler
-----------------------

ERROR CODES
===========
List of Error codes see: errorcodes.txt

Currently the error codes are not used inside patError. So patError won't mind if the error codes
are not unique. Furthermore inside pat there is some kind of chaos about error-codes :-(. But we 
promise to clean up our php-classes and order the used error-codes used by pat-internal-classes. 
At the end, there will be a list of all error-codes, defined by each pat-class. This list will 
also include a "user-space" of free error-codes that can be used without conflicting with any 
pat-class. 

Besides the trouble we have, you should keep your trouble very low. One way doing this is using 
unique error-numbers. Of course these numbers just have to be pseudo unique. It is sufficient
if you make sure, that these numbers are unique inside your application. 
