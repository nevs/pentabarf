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

function enable_save_button() {
  Element.show( 'buttons' );
  window.onbeforeunload = unloadMessage;
}

var tabs = new Array();

// find all tabs
function find_tabs() {
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
function switch_tab( target ) {   
  if ( tabs.length == 0 ) find_tabs();
  if (!target) target = tabs[0];
  for( var i = 0; i < tabs.length; i++) {
    $( 'tab-' + tabs[i] ).setAttribute('class','tab inactive');
    Element.hide( 'content-' + tabs[i] );
  }
  $( 'tab-' + target ).setAttribute('class','tab active');
  Element.show( 'content-' + target );
}

function clear_tainting() {
  window.onbeforeunload = null;
}

function unloadMessage() { 
  return "If you leave this page, your changes will be lost.";
} 


var table_row_counter = {};

function table_add_row( table_name ) {
  var row_id = table_row_counter[table_name];
  if (!row_id) {
    table_find_fields( table_name );
    row_id = 0;   
  }
  table_row_counter[table_name] = row_id + 1;

  var prefix = table_name + '[' + row_id + ']';
  var new_row = $(table_name + '_template').cloneNode(true);
  
  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $(table_name + '_tbody').appendChild( new_row );
  Element.show( table_name + '_table' );
  Element.show( new_row );
  
  if (arguments.length > 1) {
    var field_names = table_fields[table_name];
    for( var i = 1; i < arguments.length; i++ ) {
      var field = $( prefix + '[' + field_names[ i - 1] + ']' );
      if (field.type == "checkbox") {
        field.checked = arguments[i];
      } else {
        field.value = arguments[i];
      }
    }
  } else {
    enable_save_button();
  }
} 

var table_fields = {};

function table_find_fields( table_name ) {
  var cells = $(table_name + '_template').cells;
  var fields = new Array();
  for (var i = 0; i < cells.length; i++) {
    var childreen = cells[i].childNodes;
    for (var j = 0; j < childreen.length; j++) {
      var node = childreen[j].nodeName;
      if ( node == "INPUT" || node == "SELECT" ) {
        var name = childreen[j].name;
        name = name.replace( /^[a-z_]+\[row_id\]\[([a-z_]+)\]$/, "$1" );
        if ( name != "remove" ) {
          fields.push( name );   
        }
      }
    } 
  }
  table_fields[table_name] = fields;
}

