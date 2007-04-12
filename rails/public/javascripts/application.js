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

var tabs = new Array();

// find all tabs
function find_tabs()
{
  var nodes = $('tabs').childNodes;
  var outer;
  for( var i = 0; i < nodes.length; i++){
    outer = nodes[i];
    if( outer instanceof HTMLSpanElement && $( outer.id.replace('tab-', 'content-') ) ) {
      tabs.push( outer.id.replace('tab-', '') );
    }
  }
}

// switch between tabs
function switch_tab( target )
{   
  if ( tabs.length == 0 ) find_tabs();
  if (!target) target = tabs[0];
  for( var i = 0; i < tabs.length; i++) {
    $( 'tab-' + tabs[i] ).setAttribute('class','tab inactive');
    Element.hide( 'content-' + tabs[i] );
  }
  $( 'tab-' + target ).setAttribute('class','tab active');
  Element.show( 'content-' + target );
}


