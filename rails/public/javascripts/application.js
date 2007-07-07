// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// replace pattern with substitute in attributes
// recursively on all child nodes of element
function attribute_replace( element, pattern, substitute, attributes ) {
  if ( ! attributes ) attributes = ['id','name','onchange'];
  var nodes = $(element).descendants();
  for( var i = 0; i < nodes.length; i++ ) {
    var node = nodes[i];
    for( var k = 0; k < attributes.length; k++ ) {
      if ( node.getAttribute( attributes[k] ) ) {
        node.setAttribute( attributes[k], node.getAttribute( attributes[k] ).replace( pattern, substitute ) );
      }
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
  var nodes = $('tabs').descendants();
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

// add another row to a table by copying a template row
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
      if ( field.onchange ) {
        field.onchange();
      }
    }
  } else {
    var field_names = table_fields[table_name];
    for ( var i = 0; i < field_names.length; i++ ) {
      var col_name = prefix + '[' + field_names[i] + ']';
      var col = $( col_name );
      if ( col.nodeName == 'SELECT' && col.onchange ) {
        col.onchange();
      }
    }
    enable_save_button();
  }
}

var table_fields = {};

// find field names of the fields of a table by iterating
// over the template row
function table_find_fields( table_name ) {
  var cells = $(table_name + '_template').cells;
  var fields = new Array();
  for (var i = 0; i < cells.length; i++) {
    var children = cells[i].descendants();
    for (var j = 0; j < children.length; j++) {
      var node = children[j].nodeName;
      if ( node == "INPUT" || node == "SELECT" ) {
        var name = children[j].name;
        name = name.replace( /^[a-z_]+\[row_id\]\[([a-z_]+)\]$/, "$1" );
        if ( name != "remove" ) {
          fields.push( name );
        }
      }
    }
  }
  table_fields[table_name] = fields;
}

// adjust contents of slave select according to change in master select
function master_change( select, slave_column ) {
  var master_column = select.id.replace( /^.*\[([a-z_]+)\]$/, "$1" );
  var slave_id = select.id.replace( master_column, slave_column );
  var slave = $( slave_id );
  var new_value = select.value;
  var options = slave.options;
  var enabled_counter = 0;
  var first_valid;
  for (var i = 0; i < options.length; i++ ) {
    if ( options[i].className == new_value ) {
      options[i].style.display = 'block';
      enabled_counter++;
      if (!first_valid) first_valid = options[i].value;
    } else {
      options[i].style.display = 'none';
    }
  }
  if ( enabled_counter == 0 ) {
    slave.style.display = 'none';
    slave.value = '';
  } else {
    slave.style.display = 'block';
    slave.value = first_valid;
  }
}

function init_search_list( list ) {
  var target = $( list );
  var template_row = $('search_template').getElementsBySelector('li')[0];
  var selector = template_row.getElementsBySelector('select')[0];
  var content = $('search_content').getElementsBySelector('li');
  for (var i = 0; i < content.length; i++ ) {
    var new_entry = document.createElement('option');
    new_entry.text = content[i].title;
    new_entry.value = content[i].className;
    selector.add( new_entry, null );
  }
}

var search_row_counter = 0;
function search_row_add( list ) {
  var template_row = $('search_template').getElementsBySelector('li')[0];
  var new_row = template_row.cloneNode(true);
  var row_id = search_row_counter;
  search_row_counter++;

  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  new_row.className = row_id;
  $('advanced_search_list').appendChild( new_row );
  $( new_row ).getElementsBySelector('select')[0].onchange();
}

function search_row_remove( list ) {
  $(list).up().remove();
}

function search_row_change( list ) {
  var row = $(list).up();
  var row_id = row.className;
  var value = row.getElementsBySelector('select')[0].getValue();
  var target = row.getElementsBySelector('span.dynamic')[0];

  // remove old content
  var old_stuff = target.immediateDescendants();
  for ( var i = 0; i < old_stuff.length; i++ ) { Element.remove( old_stuff[i] ); }

  // add new content
  var content = $('search_content').getElementsBySelector('li.' + value)[0].immediateDescendants();
  for ( var i = 0; i < content.length; i++ ) {
    target.appendChild( content[i].cloneNode( true ) );
  }
  attribute_replace( target, /\[row_id\]/, '[' + row_id + ']' );
}


