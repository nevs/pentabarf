// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// replace pattern with substitute in attributes
// recursively on all child nodes of element
function attribute_replace( element, pattern, substitute, attributes ) {
  var nodes = element.childNodes;
  if ( ! attributes ) attributes = ['id','name','onchange'];
  for( var i = 0; i < nodes.length; i++ ) {
    var node = nodes[i];
    if ( node instanceof Element ) {
      for( var k = 0; k < attributes.length; k++ ) {
        if ( node.getAttribute( attributes[k] ) ) {
          node.setAttribute( attributes[k], node.getAttribute( attributes[k] ).replace( pattern, substitute ) );
        }
      }
      attribute_replace( node, pattern, substitute, attributes );
    }
  }
}

function enable_save_button() {}

// add a person to the table on the persons tab of the event page
var conference_language_counter = 0;

function add_conference_language( conference_language_id, language_id ) {
  var row_id = conference_language_counter++;
  var prefix = 'conference_language[' + row_id + ']';
  var new_row = $('conference_language_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('conference_language_tbody').appendChild( new_row );
  Element.show( 'conference_language_table' );
  Element.show( new_row );

  if ( conference_language_id )
    $( prefix + '[conference_language_id]' ).value = conference_language_id;
  else
    enable_save_button();

  if ( language_id ) $( prefix + '[language_id]' ).value = language_id;

}

